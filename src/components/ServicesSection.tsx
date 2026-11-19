import { Laptop, Network, PackageCheck, Printer, Video, Wrench } from 'lucide-react';
import type { ComponentType } from 'react';
import type { LucideProps } from 'lucide-react';

interface Service {
  title: string;
  description: string;
  image: string;
  icon: ComponentType<LucideProps>;
}

const services: Service[] = [
  {
    title: 'Computer & Laptop Supply',
    description: 'Desktops, laptops and tablets for offices, schools and institutions.',
    image: 'https://images.pexels.com/photos/16230157/pexels-photo-16230157.jpeg?auto=compress&cs=tinysrgb&h=650&w=940',
    icon: Laptop,
  },
  {
    title: 'Printers & Office Equipment',
    description: 'Printers, copiers, scanners and complete office technology.',
    image: 'https://images.pexels.com/photos/11833899/pexels-photo-11833899.jpeg?auto=compress&cs=tinysrgb&h=650&w=940',
    icon: Printer,
  },
  {
    title: 'Video Conferencing Solutions',
    description: 'Conference systems, cameras and servers for connected workplaces.',
    image: 'https://images.pexels.com/photos/7643888/pexels-photo-7643888.jpeg?auto=compress&cs=tinysrgb&h=650&w=940',
    icon: Video,
  },
  {
    title: 'Networking Solutions',
    description: 'Routers, switches and communication equipment for reliable connectivity.',
    image: 'https://images.pexels.com/photos/4280702/pexels-photo-4280702.jpeg?auto=compress&cs=tinysrgb&h=650&w=940',
    icon: Network,
  },
  {
    title: 'Bulk & Institutional Procurement',
    description: 'Large-scale technology supply for offices, agencies and organizations.',
    image: 'https://images.pexels.com/photos/6407567/pexels-photo-6407567.jpeg?auto=compress&cs=tinysrgb&h=650&w=940',
    icon: PackageCheck,
  },
  {
    title: 'After-Sales Support',
    description: 'Installation guidance, warranty support and responsive assistance.',
    image: 'https://images.pexels.com/photos/37605911/pexels-photo-37605911.jpeg?auto=compress&cs=tinysrgb&h=650&w=940',
    icon: Wrench,
  },
];

function ServiceCard({ service }: { service: Service }) {
  const Icon = service.icon;

  return (
    <article className="service-card group">
      <img src={service.image} alt={service.title} className="absolute inset-0 h-full w-full object-cover transition duration-700 group-hover:scale-110" />
      <div className="absolute inset-0 bg-[#04122b]/75 transition duration-500 group-hover:bg-[#3a0a1f]/70" />
      <div className="relative z-10 flex h-full flex-col items-center justify-center px-10 py-8 text-center text-white">
        <span className="service-icon mb-4"><Icon size={26} strokeWidth={2} /></span>
        <h3 className="text-[17px] font-extrabold leading-[1.2] tracking-[-0.025em]">{service.title}</h3>
        <p className="mt-2 text-[13px] leading-5 text-white/90">{service.description}</p>
      </div>
    </article>
  );
}

export function ServicesSection() {
  return (
    <section id="services" className="overflow-hidden bg-[#f8fafc] py-20 text-[#112746] sm:py-24">
      <div className="mx-auto max-w-[1320px] px-6 text-center sm:px-10 lg:px-12">
        <div className="reveal-up">
          <p className="section-kicker">What We Offer</p>
          <h2 className="mt-2 text-[38px] font-extrabold tracking-[-0.06em] sm:text-[52px]">Our Services</h2>
          <span className="mx-auto mt-5 block h-[4px] w-24 bg-[#ed1450]" />
          <p className="mx-auto mt-5 max-w-[630px] text-[15px] leading-7 text-[#6c829d]">Complete technology solutions for businesses and organizations.</p>
        </div>
      </div>

      <div className="services-viewport mt-12" aria-label="Our services">
        <div className="services-track">
          {[...services, ...services].map((service, index) => (
            <ServiceCard key={`${service.title}-${index}`} service={service} />
          ))}
        </div>
      </div>

      <div className="mx-auto mt-10 flex items-center justify-center gap-4 px-6 text-center text-[13px] font-semibold text-[#6c829d]">
        <span className="h-px w-14 bg-[#ed1450]" />
        <span>Explore everything we can do for you</span>
        <span className="h-px w-14 bg-[#ed1450]" />
      </div>
    </section>
  );
}
