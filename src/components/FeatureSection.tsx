import {
  Award,
  CalendarDays,
  Headphones,
  Handshake,
  ShieldCheck,
  Truck,
  Users,
} from 'lucide-react';
import { ABOUT_HASH } from '@/lib/routes';

const features = [
  { title: 'Quality Products', description: 'Trusted brands & reliable technology', icon: ShieldCheck },
  { title: 'Warranty Support', description: 'Confidence with product warranty', icon: ShieldCheck },
  { title: 'Free Delivery', description: 'Convenient delivery on eligible orders', icon: Truck },
  { title: 'Technical Support', description: 'Professional assistance when you need it', icon: Headphones },
];

const gallery = [
  { src: 'https://images.pexels.com/photos/16230157/pexels-photo-16230157.jpeg?auto=compress&cs=tinysrgb&h=650&w=940', alt: 'Modern computer workstation with blue screens' },
  { src: 'https://images.pexels.com/photos/11833899/pexels-photo-11833899.jpeg?auto=compress&cs=tinysrgb&h=650&w=940', alt: 'Modern printer on an office desk' },
  { src: 'https://images.pexels.com/photos/4280702/pexels-photo-4280702.jpeg?auto=compress&cs=tinysrgb&h=650&w=940', alt: 'Network switch with connected blue cables' },
  { src: 'https://images.pexels.com/photos/37605911/pexels-photo-37605911.jpeg?auto=compress&cs=tinysrgb&h=650&w=940', alt: 'IT professional working in a server room' },
];

const stats = [
  { value: '1000+', label: 'Clients & Suppliers', icon: Users },
  { value: '500+', label: 'Awards & Recognition', icon: Award },
  { value: '50+', label: 'Global Partners', icon: Handshake },
  { value: '9+', label: 'Years of Excellence', icon: CalendarDays },
];

export function FeatureSection() {
  return (
    <section id="about" className="overflow-hidden bg-[#f8fafc] text-[#112746]">
      <div id="products" className="mx-auto max-w-[1320px] px-6 pb-20 pt-20 sm:px-10 lg:px-12 lg:pb-24 lg:pt-24">
        <div className="text-center reveal-up">
          <p className="section-kicker">Our Best Features</p>
          <h2 className="mt-2 text-[34px] font-extrabold tracking-[-0.055em] sm:text-[46px]">Why Choose Variety?</h2>
          <span className="mx-auto mt-4 block h-[3px] w-20 bg-[#ed1450]" />
        </div>

        <div className="mt-12 grid gap-5 md:grid-cols-2 xl:grid-cols-4">
          {features.map(({ title, description, icon: Icon }, index) => (
            <article key={title} className="feature-card reveal-up" style={{ animationDelay: `${index * 100}ms` }}>
              <span className="feature-icon"><Icon size={28} strokeWidth={2.2} /></span>
              <div className="pt-4">
                <h3 className="text-[18px] font-extrabold tracking-[-0.025em]">{title}</h3>
                <p className="mt-2 text-[14px] leading-6 text-[#6c829d]">{description}</p>
              </div>
            </article>
          ))}
        </div>

        <div id="contact" className="mt-20 grid items-center gap-10 lg:mt-24 lg:grid-cols-[1.05fr_0.95fr] lg:gap-16">
          <div className="grid grid-cols-2 gap-2.5 reveal-left">
            {gallery.map((image, index) => (
              <div key={image.src} className="group relative aspect-[1.4] overflow-hidden rounded-xl bg-[#dce4ed] shadow-sm" style={{ animationDelay: `${index * 80}ms` }}>
                <img src={image.src} alt={image.alt} className="h-full w-full object-cover transition duration-700 group-hover:scale-110" />
                <div className="absolute inset-0 bg-[#ed1450]/0 transition-colors duration-500 group-hover:bg-[#ed1450]/15" />
              </div>
            ))}
          </div>

          <div className="reveal-right">
            <p className="section-kicker">About Us</p>
            <h2 className="mt-2 text-[32px] font-extrabold leading-[1.08] tracking-[-0.055em] sm:text-[44px]">Welcome to Variety Computer PLC</h2>
            <span className="mt-5 block h-[3px] w-20 bg-[#ed1450]" />
            <h3 className="mt-5 text-[18px] font-extrabold leading-7 text-[#ed1450] sm:text-[20px]">Where Technology, Quality, and Service Come Together</h3>
            <p className="mt-4 max-w-[580px] text-[16px] leading-7 text-[#6c829d]">From computers and laptops to printers and networking solutions, we provide reliable technology from trusted brands, backed by professional service and support.</p>
            <a href={ABOUT_HASH} className="group mt-7 inline-flex items-center gap-2 rounded-md bg-[#ed1450] px-6 py-3 text-sm font-extrabold text-white shadow-[0_12px_24px_rgba(237,20,80,0.18)] transition-all hover:-translate-y-1 hover:bg-[#c90d42] hover:shadow-[0_16px_30px_rgba(237,20,80,0.28)]">About Us <span className="transition-transform group-hover:translate-x-1">→</span></a>
          </div>
        </div>
      </div>

      <div className="relative overflow-hidden bg-[#071a35] text-white">
        <div className="absolute inset-0 bg-[url('https://images.pexels.com/photos/17489151/pexels-photo-17489151.jpeg?auto=compress&cs=tinysrgb&h=650&w=940')] bg-cover bg-center opacity-35" />
        <div className="absolute inset-0 bg-[#061936]/80" />
        <div className="relative mx-auto grid max-w-[1320px] divide-y divide-[#ed1450]/60 px-6 py-12 sm:px-10 md:grid-cols-4 md:divide-x md:divide-y-0 lg:px-12">
          {stats.map(({ value, label, icon: Icon }, index) => (
            <div key={label} className="stat-item reveal-up flex flex-col items-center gap-2 py-7 text-center first:pt-0 last:pb-0 md:py-1" style={{ animationDelay: `${index * 100}ms` }}>
              <span className="stat-icon"><Icon size={27} strokeWidth={2.4} /></span>
              <strong className="mt-1 text-[31px] font-extrabold leading-none tracking-[-0.04em]">{value}</strong>
              <span className="text-[14px] font-semibold text-white/90">{label}</span>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
