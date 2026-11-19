import { Facebook, Instagram, Twitter, Youtube } from 'lucide-react';

const socials = [
  { label: 'Facebook', icon: Facebook, href: '#facebook' },
  { label: 'Instagram', icon: Instagram, href: '#instagram' },
  { label: 'Twitter', icon: Twitter, href: '#twitter' },
  { label: 'YouTube', icon: Youtube, href: '#youtube' },
];

export function SocialRail() {
  return (
    <aside className="absolute bottom-7 left-6 z-10 hidden flex-col gap-5 text-white sm:flex lg:left-10" aria-label="Social media links">
      {socials.map(({ label, icon: Icon, href }) => (
        <a key={label} href={href} aria-label={label} className="transition-all hover:-translate-y-1 hover:text-[#f20d13]">
          <Icon size={23} strokeWidth={2.2} fill={label === 'Facebook' || label === 'Twitter' || label === 'YouTube' ? 'currentColor' : 'none'} />
        </a>
      ))}
    </aside>
  );
}
