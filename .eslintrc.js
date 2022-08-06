module.exports = {
  root: true,
  extends: [
    'airbnb-typescript/base',
  ],
  rules: {
    'semi': 'never',
  },
  plugins: ['import', 'prettier'],
  parserOptions: {
    project: './tsconfig.eslint.json',
  },
};