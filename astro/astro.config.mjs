// @ts-check
import { defineConfig } from 'astro/config'

import mdx from '@astrojs/mdx'
import preact from '@astrojs/preact'
import react from '@astrojs/react'
import remarkMath from 'remark-math'
import rehypeKatex from "rehype-katex";

export default defineConfig({
  integrations: [mdx(), preact(), react()],
  base: `/deep-learning-specialization/`,  // GitHub Pages 프로젝트 경로로 수정
  site: `https://theintrance.github.io/deep-learning-specialization`,  // GitHub Pages 배포 URL로 수정
  markdown: {
    remarkPlugins: [remarkMath],
    rehypePlugins: [rehypeKatex],
  }
})
