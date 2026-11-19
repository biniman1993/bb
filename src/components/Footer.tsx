import { useState, type FormEvent } from 'react';
import { CalendarDays, Clock3, Facebook, Instagram, Mail, MapPin, Phone, Send, Youtube } from 'lucide-react';
import { BrandMark } from './BrandMark';
import { ABOUT_HASH, CONTACT_HASH } from '@/lib/routes';

const quickLinks = [
  ['Home', '#home'],
  ['Products', '#products-range'],
  ['About Us', ABOUT_HASH],
  ['Projects', '#projects'],
  ['Blog', '#blog'],
  ['Contact', CONTACT_HASH],
];

export function Footer() {
  const [subscribed, setSubscribed] = useState(false);

  const handleSubmit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    setSubscribed(true);
  };

  return (
    <footer id="contact" className="site-footer">
      <div className="mx-auto grid max-w-[1320px] gap-12 px-6 py-14 sm:px-10 lg:grid-cols-[1.1fr_0.8fr_0.9fr_1fr] lg:gap-10 lg:px-12 lg:py-16">
        <div>
          <BrandMark />
          <p className="mt-5 max-w-[330px] text-[13px] leading-6 text-[#c0cbd7]">Your Trusted IT Partner for Computers, Office Technology, Networking and Business Solutions.</p>
          <form className="footer-subscribe mt-5" onSubmit={handleSubmit}>
            <div className="footer-email-field">
              <Mail size={17} className="shrink-0 text-[#ed1450]" />
              <input type="email" placeholder="Your Email Address" aria-label="Your Email Address" required />
            </div>
            <button type="submit" className="footer-subscribe-button">{subscribed ? 'Subscribed' : 'Subscribe'} <Send size={16} /></button>
          </form>
          {subscribed && <p className="mt-3 text-[12px] text-[#ff789c]">Thank you. You are on the list.</p>}
        </div>

        <div>
          <h2 className="footer-heading">Quick Links</h2>
          <nav className="mt-5 grid gap-3" aria-label="Footer navigation">
            {quickLinks.map(([label, href]) => (
              <a key={label} href={href} className="footer-link"><span className="footer-link-icon">{label === 'Blog' ? <Mail size={15} /> : <Send size={15} />}</span>{label}</a>
            ))}
          </nav>
        </div>

        <div>
          <h2 className="footer-heading">Opening Hours</h2>
          <div className="mt-5 grid gap-4 text-[13px] text-[#c0cbd7]">
            <p className="footer-detail"><Clock3 size={19} /><span><strong>Monday – Friday</strong><br />08:00 AM – 05:30 PM</span></p>
            <p className="footer-detail"><Clock3 size={19} /><span><strong>Saturday</strong><br />09:00 AM – 01:00 PM</span></p>
            <p className="footer-detail"><CalendarDays size={19} /><span><strong>Sunday</strong><br />Closed</span></p>
          </div>
        </div>

        <div>
          <h2 className="footer-heading">Contact Info</h2>
          <div className="mt-5 grid gap-4 text-[13px] leading-5 text-[#c0cbd7]">
            <p className="footer-detail"><MapPin size={19} /><span>Bole Medhanialem, Near Friendship<br />International Hotel, Addis Ababa, Ethiopia</span></p>
            <p className="footer-detail"><Phone size={18} /><span>+251 911 145 127&nbsp; | &nbsp;+251 113 662 626</span></p>
            <p className="footer-detail"><Mail size={18} /><span>varietycomputerplc@gmail.com</span></p>
          </div>
          <div className="mt-5 flex gap-3">
            {[{ label: 'Facebook', icon: Facebook }, { label: 'Instagram', icon: Instagram }, { label: 'X', icon: Send }, { label: 'YouTube', icon: Youtube }].map(({ label, icon: Icon }) => (
              <a key={label} href="#contact" className="footer-social" aria-label={label}><Icon size={17} /></a>
            ))}
          </div>
        </div>
      </div>
      <div className="footer-bottom">
        <p>© 2025 Variety Computer PLC. All Rights Reserved.</p>
        <span>Technology for a Better Tomorrow</span>
      </div>
    </footer>
  );
}
