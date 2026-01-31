#!/usr/bin/env node
// substitute-env.js - Replace ${VAR} placeholders in openclaw.docker.json
import { readFileSync, writeFileSync, mkdirSync, existsSync } from 'fs';
import { dirname } from 'path';
import { env } from 'process';

const templatePath = '/app/openclaw.docker.json';
const outputPath = (env.HOME || '/home/node') + '/.openclaw/openclaw.json';

// Read template
let config = readFileSync(templatePath, 'utf8');

// Replace ${VAR:-default} and ${VAR} patterns
config = config.replace(/\$\{([^:}]+)(?::-(.*?))?\}/g, (match, varName, defaultValue) => {
    return env[varName] || defaultValue || '';
});

// Ensure directory exists
const dir = dirname(outputPath);
if (!existsSync(dir)) {
    mkdirSync(dir, { recursive: true });
}

// Write output
writeFileSync(outputPath, config);
console.log(`✓ Config written to ${outputPath}`);
console.log(`  OLLAMA_BASE_URL: ${env.OLLAMA_BASE_URL}`);
