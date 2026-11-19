import { ArrowRight, Award, BadgeCheck, Boxes, Building2, Eye, Handshake, HeartHandshake, Headphones, Lightbulb, Phone, ShieldCheck, Target, Users } from 'lucide-react';
import type { ComponentType } from 'react';
import type { LucideProps } from 'lucide-react';
import { Footer } from '@/components/Footer';
import { Navbar } from '@/components/Navbar';
import { CONTACT_HASH } from '@/lib/routes';

type Icon = ComponentType<LucideProps>;

const stats = [
  { value: '9+', label: 'Years of Experience' },
  { value: '1,000+', label: 'Clients & Suppliers' },
  { value: '50+', label: 'Global Partners' },
  { value: '500+', label: 'Awards & Recognition' },
];

const values: { title: string; description: string; icon: Icon }[] = [
  { title: 'Quality & Reliability', description: 'We prioritize dependable products and trusted technology brands to deliver lasting value to our customers.', icon: ShieldCheck },
  { title: 'Customer Commitment', description: 'We put our customers first by understanding their needs and providing practical, effective solutions.', icon: Users },
  { title: 'Integrity & Trust', description: 'We conduct our business with honesty, transparency, responsibility, and professionalism.', icon: BadgeCheck },
  { title: 'Innovation', description: 'We embrace modern technology and continuously explore solutions that help organizations move forward.', icon: Lightbulb },
  { title: 'Professional Excellence', description: 'We strive for high standards in product selection, service delivery, technical assistance, and customer care.', icon: Award },
  { title: 'Strong Partnerships', description: 'We value lasting relationships with customers, suppliers, and technology partners to create shared success.', icon: Handshake },
];

const reasons: { title: string; description: string; icon: Icon }[] = [
  { title: 'Trusted Technology Brands', description: 'Access reliable products from recognized international technology manufacturers.', icon: BadgeCheck },
  { title: 'Wide Product Selection', description: 'Find computers, laptops, printers, servers, networking equipment, and office solutions in one place.', icon: Boxes },
  { title: 'Quality Assurance', description: 'We prioritize quality products and applicable manufacturer or supplier warranties.', icon: ShieldCheck },
  { title: 'Professional Support', description: 'Receive responsive assistance and technical guidance for your technology requirements.', icon: Headphones },
  { title: 'Institutional Supply', description: 'We support bulk purchasing and technology supply requirements for businesses and institutions.', icon: Building2 },
  { title: 'Customer-Focused Service', description: 'We work to understand your requirements and recommend suitable technology solutions.', icon: HeartHandshake },
];

function SectionHeader({ label, title, subtitle, light = false }: { label: string; title: string; subtitle?: string; light?: boolean }) {
  return (
    <div className="mx-auto max-w-[760px] text-center reveal-up">
      <p className="text-[12px] font-extrabold uppercase tracking-[0.2em] text-[#ed1450]">{label}</p>
      <h2 className={`mt-3 text-[32px] font-extrabold leading-[1.15] tracking-[-0.05em] sm:text-[44px] ${light ? 'text-white' : 'text-[#112746]'}`}>{title}</h2>
      {subtitle && <p className={`mt-4 text-[16px] leading-7 ${light ? 'text-white/80' : 'text-[#425a76]'}`}>{subtitle}</p>}
      <span className="mx-auto mt-5 block h-[3px] w-20 bg-[#ed1450]" />
    </div>
  );
}

export function AboutPage() {
  return (
    <main className="min-h-screen bg-[#f8fafc] text-[#112746]">
      <section className="relative overflow-hidden bg-[#071a35] pb-24 pt-40 text-white sm:pb-28 sm:pt-44">
        <img
          src="https://images.pexels.com/photos/6804068/pexels-photo-6804068.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"
          alt=""
          className="absolute inset-0 h-full w-full object-cover opacity-30"
        />
        <div className="absolute inset-0 bg-[linear-gradient(180deg,rgba(7,26,53,0.55)_0%,rgba(7,26,53,0.92)_100%)]" />
        <div className="absolute inset-x-0 top-0 h-[3px] bg-[#ed1450]" />
        <div className="absolute inset-x-0 bottom-0 h-[3px] bg-[#ed1450]/60" />
        <div className="relative z-10 mx-auto max-w-[900px] px-6 text-center reveal-up">
          <p className="text-[12px] font-extrabold uppercase tracking-[0.2em] text-[#ff789c]">About Variety Computer PLC</p>
          <h1 className="mt-4 text-[38px] font-extrabold leading-[1.1] tracking-[-0.06em] sm:text-[56px]">Technology That Moves Your Business Forward</h1>
          <p className="mx-auto mt-5 max-w-[680px] text-[16px] leading-7 text-white/85">
            Your trusted partner for computers, office equipment, networking infrastructure, and professional technology solutions. We deliver quality products and dependable service to help businesses and institutions achieve more.
          </p>
          <div className="mt-8 flex flex-wrap justify-center gap-3">
            <a href="#services" className="contact-hero-button contact-hero-button-primary">
              Explore Our Services <ArrowRight size={17} />
            </a>
            <a href={CONTACT_HASH} className="contact-hero-button">
              Contact Us
            </a>
          </div>
        </div>
        <Navbar />
      </section>

      <section className="mx-auto max-w-[1320px] px-6 py-20 sm:px-10 sm:py-24 lg:px-12">
        <div className="grid items-center gap-12 lg:grid-cols-2 lg:gap-16">
          <div className="reveal-up">
            <p className="text-[12px] font-extrabold uppercase tracking-[0.2em] text-[#ed1450]">Who We Are</p>
            <h2 className="mt-3 text-[32px] font-extrabold leading-[1.15] tracking-[-0.05em] sm:text-[44px]">Connecting Businesses Through Technology</h2>
            <div className="mt-6 grid gap-4 text-[16px] leading-7 text-[#425a76]">
              <p>
                Variety Computer PLC is an Ethiopian technology supply and solutions company committed to providing quality IT equipment, office technology, and networking solutions.
              </p>
              <p>
                Since 2016, we have focused on connecting organizations with reliable technology from recognized global manufacturers. Our diverse product range and customer-focused approach help businesses, institutions, and organizations meet their technology needs with confidence.
              </p>
              <p>
                From computers and printers to servers and advanced networking equipment, we are committed to delivering practical solutions that support productivity and growth.
              </p>
            </div>
          </div>

          <div className="reveal-up">
            <img
              src="https://images.pexels.com/photos/17489151/pexels-photo-17489151.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"
              alt="Server racks in a data center"
              className="h-[280px] w-full rounded-2xl object-cover shadow-[0_18px_40px_rgba(7,26,53,0.14)] sm:h-[340px]"
            />
            <div className="mt-6 grid grid-cols-2 gap-4">
              {stats.map(({ value, label }) => (
                <div key={label} className="rounded-xl border border-[#e4ebf2] bg-white p-5 shadow-[0_8px_22px_rgba(7,26,53,0.06)]">
                  <p className="text-[30px] font-extrabold tracking-[-0.04em] text-[#ed1450]">{value}</p>
                  <p className="mt-1 text-[13px] font-semibold text-[#425a76]">{label}</p>
                </div>
              ))}
            </div>
          </div>
        </div>
      </section>

      <section className="bg-white px-6 py-20 sm:px-10 sm:py-24 lg:px-12">
        <div className="mx-auto grid max-w-[1100px] gap-6 md:grid-cols-2">
          {[
            { label: 'What Drives Us', title: 'Our Mission', description: 'To provide quality technology products and reliable IT solutions that empower businesses and institutions to improve productivity, operate efficiently, and achieve their goals through professional service and lasting partnerships.', icon: Target },
            { label: 'Where We Are Going', title: 'Our Vision', description: "To become one of Ethiopia's leading and most trusted technology solutions providers, recognized for quality, innovation, professional excellence, and outstanding customer service.", icon: Eye },
          ].map(({ label, title, description, icon: CardIcon }, index) => (
            <article key={title} className="contact-card reveal-up" style={{ animationDelay: `${index * 90}ms` }}>
              <span className="contact-icon-badge"><CardIcon size={22} strokeWidth={2.1} /></span>
              <p className="mt-6 text-[12px] font-extrabold uppercase tracking-[0.2em] text-[#ed1450]">{label}</p>
              <h3 className="mt-2 text-[26px] font-extrabold tracking-[-0.03em] text-[#112746]">{title}</h3>
              <p className="mt-3 text-[15px] leading-7 text-[#425a76]">{description}</p>
            </article>
          ))}
        </div>
      </section>

      <section className="mx-auto max-w-[1320px] px-6 py-20 sm:px-10 sm:py-24 lg:px-12">
        <SectionHeader
          label="What We Stand For"
          title="Our Core Values"
          subtitle="The principles that guide our business, shape our relationships, and define our commitment to excellence."
        />
        <div className="mt-14 grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {values.map(({ title, description, icon: ValueIcon }, index) => (
            <article key={title} className="contact-card reveal-up" style={{ animationDelay: `${index * 70}ms` }}>
              <span className="contact-icon-badge"><ValueIcon size={22} strokeWidth={2.1} /></span>
              <h3 className="mt-5 text-[18px] font-extrabold tracking-[-0.02em] text-[#112746]">{title}</h3>
              <p className="mt-2 text-[14px] leading-6 text-[#425a76]">{description}</p>
            </article>
          ))}
        </div>
      </section>

      <section className="bg-[#071a35] px-6 py-20 text-white sm:px-10 sm:py-24 lg:px-12">
        <div className="mx-auto max-w-[1320px]">
          <SectionHeader
            light
            label="The Variety Advantage"
            title="Why Choose Variety Computer PLC?"
            subtitle="We combine quality products, professional service, and dependable technology solutions to meet the needs of modern organizations."
          />
          <div className="mt-14 grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {reasons.map(({ title, description, icon: ReasonIcon }, index) => (
              <article key={title} className="rounded-xl border border-white/10 bg-white/[0.04] p-7 transition-colors hover:border-[#ed1450]/60 reveal-up" style={{ animationDelay: `${index * 70}ms` }}>
                <span className="flex h-12 w-12 items-center justify-center rounded-full bg-[#ed1450] text-white">
                  <ReasonIcon size={22} strokeWidth={2.1} />
                </span>
                <h3 className="mt-5 text-[18px] font-extrabold tracking-[-0.02em] text-white">{title}</h3>
                <p className="mt-2 text-[14px] leading-6 text-white/80">{description}</p>
              </article>
            ))}
          </div>
        </div>
      </section>

      <section className="relative overflow-hidden bg-white px-6 py-20 sm:px-10 sm:py-24 lg:px-12">
        <div className="mx-auto grid max-w-[1100px] items-center gap-12 lg:grid-cols-2">
          <img
            src="https://images.pexels.com/photos/6804076/pexels-photo-6804076.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"
            alt="Team working on computers in a modern office"
            className="h-[280px] w-full rounded-2xl object-cover shadow-[0_18px_40px_rgba(7,26,53,0.14)] sm:h-[340px]"
          />
          <div className="reveal-up">
            <p className="text-[12px] font-extrabold uppercase tracking-[0.2em] text-[#ed1450]">Our Promise</p>
            <h2 className="mt-3 text-[30px] font-extrabold leading-[1.15] tracking-[-0.05em] sm:text-[40px]">More Than Products. We Deliver Technology Solutions.</h2>
            <p className="mt-5 text-[16px] leading-7 text-[#425a76]">
              At Variety Computer PLC, we believe the right technology creates opportunities for growth. Our commitment is to provide reliable products, practical solutions, and professional service that help our customers work smarter and move forward with confidence.
            </p>
            <a href={CONTACT_HASH} className="group mt-8 inline-flex items-center gap-2 rounded-md bg-[#ed1450] px-6 py-3 text-[14px] font-extrabold text-white shadow-[0_12px_24px_rgba(237,20,80,0.18)] transition-all hover:-translate-y-1 hover:bg-[#c90d42]">
              Talk to Our Team <ArrowRight size={17} className="transition-transform group-hover:translate-x-1" />
            </a>
          </div>
        </div>
      </section>

      <section className="bg-[#ed1450] px-6 py-16 text-center text-white sm:px-10">
        <div className="mx-auto max-w-[760px]">
          <h2 className="text-[30px] font-extrabold tracking-[-0.04em] sm:text-[38px]">Let's Build Your Technology Future Together</h2>
          <p className="mt-4 text-[16px] leading-7 text-white/90">
            Looking for reliable IT equipment, office technology, or networking solutions? Variety Computer PLC is ready to help you find the right solution for your needs.
          </p>
          <div className="mt-8 flex flex-wrap justify-center gap-3">
            <a href={CONTACT_HASH} className="inline-flex items-center gap-2 rounded-md bg-white px-6 py-3 text-[14px] font-extrabold text-[#c90d42] transition-all hover:-translate-y-1 hover:shadow-[0_14px_26px_rgba(0,0,0,0.18)]">
              <Phone size={17} /> Contact Us
            </a>
            <a href="#products" className="inline-flex items-center gap-2 rounded-md border-2 border-white px-6 py-3 text-[14px] font-extrabold text-white transition-all hover:-translate-y-1 hover:bg-white/10">
              Explore Products <ArrowRight size={17} />
            </a>
          </div>
        </div>
      </section>

      <Footer />
    </main>
  );
}
