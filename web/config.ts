// eslint-disable-next-line import/no-anonymous-default-export

const textPrimary = {
    '400': 'text-orange-400',
    '300': 'text-orange-300',
    '500': 'text-orange-500',
    '600': 'text-orange-600',
    '800': 'text-orange-800',
    '900': 'text-orange-900',
}

const bgPrimary = {
    '50': 'bg-orange-50',
    '200': 'bg-orange-200',
    '300': 'bg-orange-300',
    '500': 'bg-orange-500',
}

const fillPrimary = {
    '100': 'fill-orange-100',
    '500': 'fill-orange-500',
}

const colorsPrimary = {
    '50': 'colors.orange.50',
    '300': 'colors.orange.300',
    '500': 'colors.orange.500',
    '700': 'colors.orange.700',
    '800': 'colors.orange.800',
}

const config = {
    name: 'Butlersh',
    title: 'Butlersh - Server Management Tool',
    description:
        'Butlersh have done complicated stuff. So, it\' more convenient to manage servers using fluent commands',
    github: 'https://github.com/butlersh/butlersh',

    logomarkColor: '#F97316',

    themeSelector: {
        light: 'fill-slate-400',
        dark: 'fill-orange-400',
        textDark: textPrimary[500],
    },

    textPrimary,
    bgPrimary,
    fillPrimary,
    colorsPrimary,

    hero: {
        language: 'bash',
        code: ``,
        tabActiveClass: 'from-orange-400/30 via-orange-400 to-orange-400/30 ' + textPrimary[300],
        tabs: [
            { name: 'installer.sh', isActive: true },
        ],
        headingClass: 'from-orange-400 via-orange-500 to-orange-600',
        getStartedUrl: '/docs/get-started',
    },

    components: {
        button: {
            primaryClasses: `${bgPrimary[300]} text-slate-900 hover:${bgPrimary[200]} focus-visible:outline-orange-300/50 active:${bgPrimary[500]}`,
        },
    },
}

export default config
