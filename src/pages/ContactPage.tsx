import { ArrowRight, Building2, Clock3, Mail, MapPin, Phone, Store, UserRound } from 'lucide-react';
import type { ComponentType } from 'react';
import type { LucideProps } from 'lucide-react';
import { ContactMap } from '@/components/ContactMap';
import { Footer } from '@/components/Footer';
import { Navbar } from '@/components/Navbar';

const ADDRESS = 'Bole Medhanialem, Near Friendship International Hotel, Addis Ababa, Ethiopia';
const PHONE_PRIMARY = '+251 911 145 127';
const PHONE_SECONDARY = '+251 113 662 626';
const EMAIL = 'varietycomputerplc@gmail.com';

const telHref = (phone: string) => `tel:${phone.replace(/\s/g, '')}`;

interface LocationCard {
  title: string;
  icon: ComponentType<LucideProps>;
  address: string;
  hours?: string;
  phones: string[];
  email: string;
}

const locations: LocationCard[] = [
  {
    title: 'Main Shop',
    icon: Store,
    address: ADDRESS,
    hours: 'Monday – Friday, 08:00 AM – 05:30 PM',
    phones: [PHONE_PRIMARY, PHONE_SECONDARY],
    email: EMAIL,
  },
  {
    title: 'Head Office',
    icon: Building2,
    address: ADDRESS,
    hours: 'Monday – Friday, 08:00 AM – 05:30 PM',
    phones: [PHONE_PRIMARY, PHONE_SECONDARY],
    email: EMAIL,
  },
];

interface ManagerCard {
  name: string;
  phone: string;
  email: string;
}

const managers: ManagerCard[] = [
  { name: 'Mr. Meselu', phone: PHONE_PRIMARY, email: EMAIL },
  { name: 'Mr. Tibebu Sium', phone: PHONE_SECONDARY, email: EMAIL },
];

export function ContactPage() {
  return (
    <main className="min-h-screen bg-[#f8fafc] text-[#112746]">
      <section className="relative overflow-hidden bg-[#071a35] pb-24 pt-40 text-white sm:pb-28 sm:pt-44">
        <img
          src="https://images.pexels.com/photos/7689856/pexels-photo-7689856.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"
          alt=""
          className="absolute inset-0 h-full w-full object-cover opacity-30"
        />
        <div className="absolute inset-0 bg-[linear-gradient(180deg,rgba(7,26,53,0.55)_0%,rgba(7,26,53,0.92)_100%)]" />
        <div className="absolute inset-x-0 top-0 h-[3px] bg-[#ed1450]" />
        <div className="absolute inset-x-0 bottom-0 h-[3px] bg-[#ed1450]/60" />
        <div className="relative z-10 mx-auto max-w-[1000px] px-6 text-center reveal-up">
          <p className="section-kicker">Contact Us</p>
          <h1 className="mt-3 text-[38px] font-extrabold leading-[1.1] tracking-[-0.06em] sm:text-[56px]">Let Us Connect</h1>
          <p className="mx-auto mt-5 max-w-[620px] text-[16px] leading-7 text-white/85">
            Visit our shop, reach our head office, or speak directly with our managers. We are ready to help with products, services, and support.
          </p>
          <div className="mt-8 flex flex-wrap justify-center gap-3">
            <a href={telHref(PHONE_PRIMARY)} className="contact-hero-button contact-hero-button-primary">
              <Phone size={17} /> Call Us
            </a>
            <a href={`mailto:${EMAIL}`} className="contact-hero-button">
              <Mail size={17} /> Email Us
            </a>
          </div>
        </div>
        <Navbar />
      </section>

      <section className="mx-auto max-w-[1320px] px-6 py-20 sm:px-10 sm:py-24 lg:px-12">
        <div className="text-center reveal-up">
          <p className="section-kicker">Our Locations</p>
          <h2 className="mt-2 text-[32px] font-extrabold tracking-[-0.05em] sm:text-[44px]">Find Us Easily</h2>
          <span className="mx-auto mt-4 block h-[3px] w-20 bg-[#ed1450]" />
        </div>

        <div className="mt-12 grid gap-8 lg:grid-cols-[1fr_1.1fr] lg:items-stretch">
          <div className="grid gap-6">
            {locations.map(({ title, icon: Icon, address, hours, phones, email }, index) => (
              <article key={title} className="contact-card reveal-up" style={{ animationDelay: `${index * 90}ms` }}>
                <div className="flex items-center gap-4">
                  <span className="contact-icon-badge"><Icon size={22} strokeWidth={2.1} /></span>
                  <h3 className="text-[21px] font-extrabold tracking-[-0.03em] text-[#112746]">{title}</h3>
                </div>
                <div className="mt-6 grid gap-4 text-[14px] text-[#425a76]">
                  <p className="contact-row"><MapPin size={18} /><span>{address}</span></p>
                  {hours && <p className="contact-row"><Clock3 size={18} /><span>{hours}</span></p>}
                  {phones.map((phone) => (
                    <a key={phone} href={telHref(phone)} className="contact-row contact-link"><Phone size={18} /><span>{phone}</span></a>
                  ))}
                  <a href={`mailto:${email}`} className="contact-row contact-link"><Mail size={18} /><span>{email}</span></a>
                </div>
              </article>
            ))}
          </div>
          <ContactMap />
        </div>
      </section>

      <section className="bg-white px-6 py-20 sm:px-10 sm:py-24 lg:px-12">
        <div className="mx-auto max-w-[1320px]">
          <div className="text-center reveal-up">
            <p className="section-kicker">Our Managers</p>
            <h2 className="mt-2 text-[32px] font-extrabold tracking-[-0.05em] sm:text-[44px]">Speak With a Manager</h2>
            <span className="mx-auto mt-4 block h-[3px] w-20 bg-[#ed1450]" />
          </div>

          <div className="mx-auto mt-12 grid max-w-[900px] gap-8 md:grid-cols-2">
            {managers.map(({ name, phone, email }, index) => (
              <article key={name} className="manager-card reveal-up" style={{ animationDelay: `${index * 90}ms` }}>
                <span className="manager-avatar"><UserRound size={44} strokeWidth={1.8} /></span>
                <p className="mt-5 text-[11px] font-extrabold uppercase tracking-[0.2em] text-[#ed1450]">Manager</p>
                <h3 className="mt-2 text-[22px] font-extrabold tracking-[-0.03em] text-[#112746]">{name}</h3>
                <div className="mt-6 grid w-full gap-3 border-t border-[#e4ebf2] pt-6 text-[14px]">
                  <a href={telHref(phone)} className="contact-row contact-link justify-center"><Phone size={17} /><span>{phone}</span></a>
                  <a href={`mailto:${email}`} className="contact-row contact-link justify-center"><Mail size={17} /><span>{email}</span></a>
                </div>
              </article>
            ))}
          </div>
        </div>
      </section>

      <section className="bg-[#ed1450] px-6 py-14 text-center text-white sm:px-10">
        <div className="mx-auto max-w-[760px]">
          <h2 className="text-[28px] font-extrabold tracking-[-0.04em] sm:text-[34px]">Ready to start a project with us?</h2>
          <p className="mt-3 text-[15px] leading-7 text-white/90">Our team is available during working hours to help you choose the right technology for your business.</p>
          <a href="#home" className="mt-7 inline-flex items-center gap-2 rounded-md bg-white px-6 py-3 text-[14px] font-extrabold text-[#c90d42] transition-all hover:-translate-y-1 hover:shadow-[0_14px_26px_rgba(0,0,0,0.18)]">
            Back to Home <ArrowRight size={17} />
          </a>
        </div>
      </section>

      <Footer />
    </main>
  );
}
