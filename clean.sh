#!/bin/bash

# OpenAPI 문서 완전 정리 스크립트
# 사용법: ./clean_openapi.sh <입력파일> <출력파일>

if [ $# -ne 2 ]; then
    echo "사용법: $0 <입력파일> <출력파일>"
    echo "예시: $0 original/jira-latest-filtered-redocly.json cleaned/jira-latest-cleaned.json"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"

# 출력 디렉토리가 없으면 생성
mkdir -p "$(dirname "$OUTPUT_FILE")"

echo "OpenAPI 문서 정리 시작..."
echo "입력 파일: $INPUT_FILE"
echo "출력 파일: $OUTPUT_FILE"

jq '
# 모든 $ref 패턴을 재귀적으로 수집하는 함수
def collect_all_component_refs:
  [.. | objects | select(has("$ref")) | ."$ref" | select(startswith("#/components/"))] | unique;

# 실제 사용되는 태그 수집
def collect_used_tags:
  [.paths[]?[]?.tags[]?] | unique;

# 컴포넌트 참조를 타입과 이름으로 파싱
def parse_component_refs(refs):
  refs | map(
    if startswith("#/components/") then
      split("/") | if length >= 4 then {type: .[2], name: .[3]} else empty end
    else
      empty
    end
  ) | unique_by(.type + "/" + .name);

# 중첩된 참조를 재귀적으로 찾는 함수
def find_nested_component_refs(current_refs):
  current_refs as $current |

  # 현재 참조된 컴포넌트들 내부에서 추가 참조 찾기
  [
    $current[] as $ref |
    if .components and .components[$ref.type] and .components[$ref.type][$ref.name] then
      .components[$ref.type][$ref.name] |
      [.. | objects | select(has("$ref")) | ."$ref" | select(startswith("#/components/"))] |
      .[] | split("/") | if length >= 4 then {type: .[2], name: .[3]} else empty end
    else
      empty
    end
  ] as $new_refs |

  ($current + $new_refs) | unique_by(.type + "/" + .name) as $combined |

  if ($combined | length) > ($current | length) then
    find_nested_component_refs($combined)
  else
    $combined
  end;

# 메인 처리 로직
collect_all_component_refs as $direct_refs |
collect_used_tags as $used_tags |
parse_component_refs($direct_refs) as $parsed_refs |
find_nested_component_refs($parsed_refs) as $all_used_refs |

# 사용되지 않는 태그 제거
if .tags then
  .tags |= map(select(.name as $tag_name | $used_tags | index($tag_name)))
else . end |

# 사용되지 않는 컴포넌트 제거
if .components then
  .components |= (
    # schemas 정리
    if .schemas then
      .schemas |= with_entries(
        select(.key as $k | $all_used_refs | any(.type == "schemas" and .name == $k))
      )
    else . end |

    # responses 정리
    if .responses then
      .responses |= with_entries(
        select(.key as $k | $all_used_refs | any(.type == "responses" and .name == $k))
      )
    else . end |

    # parameters 정리
    if .parameters then
      .parameters |= with_entries(
        select(.key as $k | $all_used_refs | any(.type == "parameters" and .name == $k))
      )
    else . end |

    # examples 정리
    if .examples then
      .examples |= with_entries(
        select(.key as $k | $all_used_refs | any(.type == "examples" and .name == $k))
      )
    else . end |

    # requestBodies 정리
    if .requestBodies then
      .requestBodies |= with_entries(
        select(.key as $k | $all_used_refs | any(.type == "requestBodies" and .name == $k))
      )
    else . end |

    # headers 정리
    if .headers then
      .headers |= with_entries(
        select(.key as $k | $all_used_refs | any(.type == "headers" and .name == $k))
      )
    else . end |

    # securitySchemes 정리
    if .securitySchemes then
      .securitySchemes |= with_entries(
        select(.key as $k | $all_used_refs | any(.type == "securitySchemes" and .name == $k))
      )
    else . end |

    # links 정리
    if .links then
      .links |= with_entries(
        select(.key as $k | $all_used_refs | any(.type == "links" and .name == $k))
      )
    else . end |

    # callbacks 정리
    if .callbacks then
      .callbacks |= with_entries(
        select(.key as $k | $all_used_refs | any(.type == "callbacks" and .name == $k))
      )
    else . end
  )
else . end |

# 빈 객체와 배열 정리
walk(
  if type == "object" then
    with_entries(select(.value != null and .value != {} and .value != []))
  else . end
)
' "$INPUT_FILE" > "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "✅ OpenAPI 문서 정리가 완료되었습니다!"

    # 정리 결과 통계 출력
    echo ""
    echo "정리 결과 통계:"

    # 원본 파일 크기
    ORIGINAL_SIZE=$(wc -c < "$INPUT_FILE" | tr -d ' ')
    CLEANED_SIZE=$(wc -c < "$OUTPUT_FILE" | tr -d ' ')
    REDUCTION=$(echo "scale=1; ($ORIGINAL_SIZE - $CLEANED_SIZE) * 100 / $ORIGINAL_SIZE" | bc -l 2>/dev/null || echo "계산불가")

    echo "파일 크기: $(numfmt --to=iec $ORIGINAL_SIZE) → $(numfmt --to=iec $CLEANED_SIZE) (${REDUCTION}% 감소)"

    # 컴포넌트 개수 비교 (jq가 설치되어 있는 경우에만)
    if command -v jq >/dev/null 2>&1; then
        ORIG_SCHEMAS=$(jq -r '.components.schemas // {} | length' "$INPUT_FILE" 2>/dev/null || echo "0")
        CLEAN_SCHEMAS=$(jq -r '.components.schemas // {} | length' "$OUTPUT_FILE" 2>/dev/null || echo "0")

        ORIG_TAGS=$(jq -r '.tags // [] | length' "$INPUT_FILE" 2>/dev/null || echo "0")
        CLEAN_TAGS=$(jq -r '.tags // [] | length' "$OUTPUT_FILE" 2>/dev/null || echo "0")

        echo "스키마: $ORIG_SCHEMAS → $CLEAN_SCHEMAS"
        echo "태그: $ORIG_TAGS → $CLEAN_TAGS"
    fi

    echo ""
    echo "정리된 파일: $OUTPUT_FILE"
else
    echo "❌ 오류가 발생했습니다. jq가 설치되어 있는지 확인해주세요."
    exit 1
fi
