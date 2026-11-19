import { Mail, Menu, X } from 'lucide-react';
import { useEffect, useState } from 'react';
import { BrandMark } from './BrandMark';
import { ABOUT_HASH, CLIENTS_HASH, CONTACT_HASH } from '@/lib/routes';

const links = ['Home', 'About', 'Products', 'Clients', 'Contact', 'Blog'];

const routeHashes: Record<string, string> = {
  Home: '#home',
  About: ABOUT_HASH,
  Products: '#products-range',
  Clients: CLIENTS_HASH,
  Contact: CONTACT_HASH,
  Blog: '#blog',
};

const hrefFor = (link: string) => routeHashes[link];

function getActiveLink(hash: string): string {
  if (hash === ABOUT_HASH) return 'About';
  if (hash === '#products-range') return 'Products';
  if (hash === CLIENTS_HASH) return 'Clients';
  if (hash === CONTACT_HASH) return 'Contact';
  if (hash === '#blog' || hash.startsWith('#blog/')) return 'Blog';
  return 'Home';
}

export function Navbar() {
  const [open, setOpen] = useState(false);
  const [activeLink, setActiveLink] = useState(() => getActiveLink(window.location.hash));

  useEffect(() => {
    const handleHashChange = () => setActiveLink(getActiveLink(window.location.hash));
    window.addEventListener('hashchange', handleHashChange);
    return () => window.removeEventListener('hashchange', handleHashChange);
  }, []);

  return (
    <header className="fixed inset-x-0 top-0 z-50 border-b border-white/[0.08] bg-[#030609]/85 shadow-[0_6px_24px_rgba(0,0,0,0.18)] backdrop-blur-md">
      <div className="mx-auto flex h-[88px] max-w-[1240px] items-center justify-between px-6 lg:px-10">
        <BrandMark />
        <nav className="hidden items-center gap-10 lg:flex" aria-label="Primary navigation">
          {links.map((link) => {
            const isActive = activeLink === link;
            return (
              <a
                key={link}
                href={hrefFor(link)}
                aria-current={isActive ? 'page' : undefined}
                className={`relative py-2 text-[17px] font-medium transition-colors after:absolute after:bottom-0 after:left-0 after:h-0.5 after:bg-[#f20d13] after:transition-all ${isActive ? 'text-[#f20d13] after:w-full' : 'text-white/90 after:w-0 hover:text-[#f20d13] hover:after:w-full'}`}
              >
                {link}
              </a>
            );
          })}
        </nav>
        <div className="hidden items-center gap-8 sm:flex">
          <a href="mailto:hello@varietycomputer.com" className="text-white transition-colors hover:text-[#f20d13]" aria-label="Email Variety Computer">
            <Mail size={27} strokeWidth={1.6} />
          </a>
          <a href="tel:+25191145127" className="text-[17px] font-medium text-[#f20d13] transition-colors hover:text-white">
            +251911145127
          </a>
        </div>
        <button type="button" className="text-white lg:hidden" onClick={() => setOpen(!open)} aria-label={open ? 'Close menu' : 'Open menu'}>
          {open ? <X size={27} /> : <Menu size={27} />}
        </button>
      </div>
      {open && (
        <nav className="border-t border-white/10 bg-[#030609] px-6 py-5 lg:hidden" aria-label="Mobile navigation">
          <div className="flex flex-col gap-5">
            {links.map((link) => {
              const isActive = activeLink === link;
              return (
                <a
                  key={link}
                  href={hrefFor(link)}
                  onClick={() => setOpen(false)}
                  aria-current={isActive ? 'page' : undefined}
                  className={`border-l-2 pl-3 text-base transition-colors ${isActive ? 'border-[#f20d13] text-[#f20d13]' : 'border-transparent text-white hover:text-[#f20d13]'}`}
                >
                  {link}
                </a>
              );
            })}
            <a href="tel:+25191145127" className="text-base text-[#f20d13] sm:hidden">+251911145127</a>
          </div>
        </nav>
      )}
    </header>
  );
}
