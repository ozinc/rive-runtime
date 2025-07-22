workspace('rive')
configurations({ 'debug', 'release' })

project('rivinfo')
kind('ConsoleApp')
language('C++')
cppdialect('C++17')
targetdir('%{cfg.system}/bin/%{cfg.buildcfg}')
objdir('%{cfg.system}/obj/%{cfg.buildcfg}')
includedirs({
    '../../include',
    '../../test',
    '/usr/local/include',
    '/usr/include',
})

links({
    'm',
    'z',
    'dl',
    'rive',
    'rive_yoga',
    'rive_harfbuzz',
    'rive_sheenbidi',
    'miniaudio'
})

libdirs({
    '../../build/%{cfg.system}/bin/%{cfg.buildcfg}',
    '/usr/local/lib',
    '/usr/lib',
    '../../out/release',
})

files({ '../**.cpp', '../../utils/no_op_factory.cpp' })

buildoptions({ '-Wall', '-fno-rtti', '-g' })

filter('configurations:debug')
defines({ 'DEBUG' })
symbols('On')

filter('configurations:release')
defines({ 'RELEASE' })
defines({ 'NDEBUG' })
optimize('On')

-- Clean Function --
newaction({
    trigger = 'clean',
    description = 'clean the build',
    execute = function()
        print('clean the build...')
        os.rmdir('./bin')
        os.rmdir('./obj')
        os.remove('Makefile')
        -- no wildcards in os.remove, so use shell
        os.execute('rm *.make')
        print('build cleaned')
    end,
})
