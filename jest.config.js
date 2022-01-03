module.exports = {
  roots: [
    "spec/javascripts"
  ],
  moduleDirectories: [
    "node_modules",
    "frontend"
  ],
  moduleNameMapper: {
    "^vue$": "vue/dist/vue.common.js"
  },
  moduleFileExtensions: [
    "js",
    "vue",
    "json"
  ],
  transform: {
    "^.+\\.js$": "<rootDir>/node_modules/babel-jest",
    ".*\\.(vue)$": "<rootDir>/node_modules/vue-jest"
  },
  collectCoverage: true,
  collectCoverageFrom: [
    '<rootDir>/frontend/init/**/*.{js,vue}',
    '<rootDir>/frontend/components/**/*.{js,vue}',
    '<rootDir>/frontend/store/**/*.{js,vue}',
    '<rootDir>/frontend/pages/**/*.{js,vue}'
  ]
}
