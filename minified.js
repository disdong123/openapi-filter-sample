const fs = require('fs');

const files = [
    'argocd-2.14.2.json',
    'argoworkflow-3.5.4.json',
    'grafana-11.4.0.json',
    // 'gitlab-latest-filtered-redocly.json',
    // 'jira-latest-filtered-redocly.json',
    'jira-latest-cleaned.json',
    'gitlab-latest-cleaned.json'
]

files.forEach(file => {
    const raw = fs.readFileSync(`original/${file}`, 'utf-8');
    const minified = JSON.stringify(JSON.parse(raw));

    fs.writeFileSync(`minified/${file}`, minified);
    console.log(`${file} 줄바꿈 제거 완료`);
})

