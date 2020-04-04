import os

BASE = os.path.dirname(os.path.abspath(__file__))
PKG_FILE = f'{BASE}/packages.x86_64'

aur_link = lambda x: f'https://aur.archlinux.org/{x}.git'


def iter_lines(file):
    for line in file.readlines():
        line = line.strip()

        if '#' not in line and line:
            yield line


if __name__ == '__main__':
    for pkg in iter_lines(open(PKG_FILE, 'r+')):
        print(aur_link(pkg))
