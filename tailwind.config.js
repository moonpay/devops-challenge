/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './components/**/*.{js,ts,jsx,tsx}',
    './app/**/*.{js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        'moonpay': '#7715F5',
        'cosmos': '#39107A',
      },
      fontFamily: {
        default: ['var(--font-luna)'],
      },
    },
  },
  plugins: [],
}
