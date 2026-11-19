import type { CSSProperties } from 'react';
import { ArrowRight, Building2 } from 'lucide-react';
import { Footer } from '@/components/Footer';
import { Navbar } from '@/components/Navbar';
import { CONTACT_HASH } from '@/lib/routes';

const clients = [
  'Office of Prime Minister',
  'Ministry of Finance',
  'Ministry of Defence',
  'Ministry of Peace',
  'Ministry of Justice',
  'Ministry of Revenues',
  'Ministry of Foreign Affairs',
  'Ministry of Trade and Regional Integration',
  'Ministry of Transport and Logistics',
  'Ministry of Water and Energy',
  'Ministry of Works and Urban Development',
  'Ministry of Urban and Infrastructure Development',
  'Ministry of Innovation and Technology',
  'Ministry of Mines and Petroleum',
  'Ministry of Agriculture',
  'Ministry of Education',
  'Ministry of Health',
  'Ministry of Labour and Skills',
  'Ministry of Women and Social Affairs',
  'Ministry of Culture and Tourism',
  'Ethiopian Airlines',
  'Ethio-telecom',
  'Ethiopian Railways Corporation',
  'Ethiopian Roads Authority',
];

function ClientRow({ hidden = false }: { hidden?: boolean }) {
  return (
    <div className="brands-row" aria-hidden={hidden}>
      {clients.map((client, index) => (
        <div
          key={`${client}-${hidden ? 'copy' : 'main'}`}
          className="client-logo-chip"
          style={{ '--client-tilt': index % 2 === 0 ? '-1deg' : '1deg' } as CSSProperties}
        >
          <span className="client-logo-mark"><Building2 size={19} strokeWidth={2.2} /></span>
          <span>{client}</span>
        </div>
      ))}
    </div>
  );
}

export function ClientsPage() {
  return (
    <main className="min-h-screen bg-[#f8fafc] text-[#112746]">
      <Navbar />
      <section className="relative overflow-hidden bg-[#071a35] px-6 pb-24 pt-40 text-white sm:px-10 sm:pb-28 sm:pt-48 lg:px-12">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(237,20,80,0.3),transparent_42%),linear-gradient(135deg,#071a35_0%,#0b2c52_100%)]" />
        <div className="absolute inset-x-0 bottom-0 h-1 bg-[#ed1450]" />
        <div className="relative mx-auto max-w-[900px] text-center reveal-up">
          <p className="text-[12px] font-extrabold uppercase tracking-[0.2em] text-[#ff789c]">Our Clients</p>
          <h1 className="mt-4 text-[38px] font-extrabold leading-[1.1] tracking-[-0.06em] sm:text-[58px]">Organizations We Serve</h1>
          <p className="mx-auto mt-5 max-w-[700px] text-[16px] leading-7 text-white/80">
            We are proud to work with leading public institutions, national organizations, and businesses across Ethiopia.
          </p>
        </div>
      </section>

      <section className="overflow-hidden bg-white py-20 sm:py-28">
        <div className="mx-auto max-w-[1320px] px-6 text-center sm:px-10 lg:px-12">
          <p className="section-kicker">Trusted Partnerships</p>
          <h2 className="mt-3 text-[32px] font-extrabold tracking-[-0.055em] sm:text-[46px]">Our Clients</h2>
          <p className="mx-auto mt-4 max-w-[680px] text-[15px] leading-7 text-[#7287a1]">Organizations that trust Variety Computer for dependable technology products and professional support.</p>
          <span className="mx-auto mt-5 block h-[3px] w-20 bg-[#ed1450]" />
        </div>

        <div className="brands-viewport mt-14" aria-label="Organizations served">
          <div className="brands-track">
            <ClientRow />
            <ClientRow hidden />
          </div>
        </div>

        <div className="mx-auto mt-16 max-w-[760px] px-6 text-center sm:px-10">
          <p className="text-[15px] leading-7 text-[#425a76]">Our partnerships are built on quality, responsiveness, and a shared commitment to helping organizations work better through technology.</p>
          <a href={CONTACT_HASH} className="group mt-7 inline-flex items-center gap-2 rounded-md bg-[#ed1450] px-6 py-3 text-[14px] font-extrabold text-white shadow-[0_12px_24px_rgba(237,20,80,0.18)] transition-all hover:-translate-y-1 hover:bg-[#c90d42]">
            Work With Us <ArrowRight size={17} className="transition-transform group-hover:translate-x-1" />
          </a>
        </div>
      </section>
      <Footer />
    </main>
  );
}
