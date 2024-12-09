// eslint-disable-next-line import/no-anonymous-default-export

const config = {
    name: 'Butlersh',
    defaultTitle: 'Butlersh - Server Management Tool',
    description:
        'Butlersh have done complicated stuff, which help manage servers more easily via fluent commands',

    hero: {
        language: 'bash',
        code: `wget -qO https://butlersh-stg.confetticode.com/installer.sh > installer.sh

bash installer.sh

butlersh --version`,
        tabs: [
            { name: 'Installation', isActive: true },
        ]
    },
}

export default config
