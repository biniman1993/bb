import type { CSSProperties } from 'react';

const brands = [
  'HP',
  'Lenovo',
  'Dell',
  'ASUS',
  'Acer',
  'Apple',
  'Epson',
  'Canon',
  'Brother',
  'Kyocera',
  'Xerox',
  'Ricoh',
  'Cisco',
  'Huawei',
  'TP-Link',
  'Ubiquiti',
  'HPE',
  'Fortinet',
  'MikroTik',
  'APC',
];

function BrandRow({ hidden = false }: { hidden?: boolean }) {
  return (
    <div className="brands-row" aria-hidden={hidden}>
      {brands.map((brand, index) => (
        <div key={`${brand}-${hidden ? 'copy' : 'main'}`} className="brand-chip" style={{ '--brand-tilt': index % 2 === 0 ? '-2deg' : '2deg' } as CSSProperties}>
          <span className="brand-dot" />
          <span>{brand}</span>
        </div>
      ))}
    </div>
  );
}

export function BrandsSection() {
  return (
    <section id="brands" className="brands-section overflow-hidden bg-white py-16 text-[#112746] sm:py-20">
      <div className="mx-auto max-w-[1320px] px-6 text-center sm:px-10 lg:px-12">
        <div className="reveal-up">
          <p className="section-kicker">Trusted Technology Partners</p>
          <h2 className="mt-2 text-[32px] font-extrabold tracking-[-0.055em] sm:text-[44px]">Our Brands</h2>
          <span className="mx-auto mt-4 block h-[3px] w-20 bg-[#ed1450]" />
          <p className="mx-auto mt-4 max-w-[580px] text-[15px] leading-7 text-[#7287a1]">We work with the world&apos;s leading technology brands to bring you quality you can trust.</p>
        </div>
      </div>

      <div className="brands-viewport mt-12" aria-label="Technology brands">
        <div className="brands-track">
          <BrandRow />
          <BrandRow hidden />
        </div>
      </div>

      <p className="mt-8 text-center text-[12px] font-semibold uppercase tracking-[0.18em] text-[#8ba0b7]">Quality technology. Reliable service.</p>
    </section>
  );
}
