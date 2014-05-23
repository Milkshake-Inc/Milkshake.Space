module.exports = function (grunt)
{
    grunt.loadNpmTasks('grunt-contrib-connect');
    grunt.loadNpmTasks('grunt-open');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-haxe');
    grunt.loadNpmTasks('grunt-notify');
    grunt.loadNpmTasks('grunt-concurrent');    
    grunt.loadNpmTasks('grunt-sass');

    grunt.initConfig(
    {
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

        copy:
        {
            main:
            {
                files: [{
                            cwd: 'assets/html/',
                            expand: true,
                            src: ['**'],
                            dest: 'bin'
                        },
                        {
                            cwd: 'assets/',
                            expand: true,
                            src: ['scenes/**'],
                            dest: 'bin'
                        }]
            }
        },

        open:
        {
            dev: {
                path: 'http://localhost:8080/index.html'
            }
        },

        haxe:
        {
            main:
            {
                hxml: 'build_javascript.hxml'
            }
        },

        sass:
        {
            options:
            {
                compass:true
            },      

            dist:
            {
                files:
                {
                    'bin/styles/app.css' : 'assets/html/styles/app.scss'
                }
            }
        },

        watch:
        {
            scss:
            {
                files: '**/*.scss',
                tasks: ['sass', 'notify:scss']
            },

            haxe:
            {
                files: '**/*.hx',
                tasks: ['haxe:main', 'notify:haxe']
            }
        },

        notify:
        {
            haxe:
            {
                options:
                {
                    title: 'Haxe',
                    message: 'Compiled!'
                }
            },

            scss:
            {
                options:
                {
                    title: 'SCSS',
                    message: 'Compiled!'
                }
            },
        },

        concurrent:
        {
            options:
            {
               logConcurrentOutput: true
            },
            watch_n_connect:
            {
                tasks: [ "watch:haxe", "watch:scss", "connect" ]
            }
        }
    });


    grunt.registerTask('default', ['copy', 'open', 'concurrent:watch_n_connect']);
}