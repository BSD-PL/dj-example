from setuptools import setup


setup(
    name='django-example',
    version='0.0.0',
    description='Django Example',
    author='Polish BSD Users Group',
    author_email='bsd-pl@gmail.com',
    package_dir={'fudo': ''},
    packages=[
        'example',
        'example.polls',
    ],
    include_package_data=True,
    install_requires=[
        'django==2.1.5',
        'psycopg2==2.7.6.1',
    ],
    zip_safe=False,
)
