project(
    'network',
    'vala', 'c',
    version: '2.1.0'
)

gettext_name = meson.project_name() + '-indicator'
i18n = import('i18n')

prefix = get_option('prefix')
libdir = join_paths(prefix, get_option('libdir'))

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language:'c')

add_project_arguments(
    '--vapidir', join_paths(meson.current_source_dir(), 'vapi'),
    language: 'vala'
)

i18n = import('i18n')

lib_install_dir = join_paths(get_option('prefix'), get_option(
    'libdir'), 'budgie-desktop', 'plugins', meson.project_name())

subdir('src')
subdir('data')
subdir('po')
