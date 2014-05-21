module.exports = function (grunt) {

    grunt.loadNpmTasks('grunt-contrib-connect');
    grunt.loadNpmTasks('grunt-open');
    grunt.loadNpmTasks('grunt-contrib-copy');

    grunt.initConfig({
        connect:
        {
            server:
            {
                options:
                {
                    port: 8080,
                    base: './bin',
                    keepalive: true,
                    hostname: '*'
                }
            }
        },

        copy: {
            main: {
                files: [
                    {cwd: 'assets/html/', expand: true, src: ['**'], dest: 'bin'},
                    {cwd: 'assets/' , expand: true, src: ['scenes/**'], dest: 'bin'}
                ]
            }
        },

        open:
        {
            dev: {
                path: 'http://localhost:8080/index.html'
            }
        }
    });

    grunt.registerTask('default', ['copy', 'open', 'connect']);
}