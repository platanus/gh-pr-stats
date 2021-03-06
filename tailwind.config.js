/* eslint-disable no-undef */
module.exports = {
  purge: {
    enabled: process.env.NODE_ENV === 'production',
    content: [
      './app/**/*.html',
      './app/**/*.vue',
      './app/**/*.js',
      './app/**/*.erb',
    ],
  },
  theme: {
    extend: {
      fontFamily: {
        'main': ['Roboto', 'sans-serif'],
        'landing': ['Roboto', 'sans-serif'],
      },
      colors: {
        primary: '#2fcab5',
      },
    },
  },
  variants: {},
  plugins: [],
};
