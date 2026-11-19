import { MapPin } from 'lucide-react';

export function ContactMap() {
  return (
    <div className="relative h-full min-h-[320px] overflow-hidden rounded-2xl border border-[#dce6f0] bg-[#e8f0f7] shadow-[0_18px_40px_rgba(17,39,70,0.1)]">
      <svg viewBox="0 0 600 420" className="absolute inset-0 h-full w-full" preserveAspectRatio="xMidYMid slice" aria-hidden="true">
        <rect width="600" height="420" fill="#e8f0f7" />
        <g fill="#f7fafd">
          <rect x="30" y="30" width="150" height="100" rx="8" />
          <rect x="210" y="30" width="110" height="100" rx="8" />
          <rect x="350" y="30" width="220" height="60" rx="8" />
          <rect x="30" y="160" width="95" height="110" rx="8" />
          <rect x="155" y="160" width="165" height="90" rx="8" />
          <rect x="350" y="120" width="90" height="130" rx="8" />
          <rect x="470" y="120" width="100" height="130" rx="8" />
          <rect x="30" y="300" width="200" height="100" rx="8" />
          <rect x="260" y="280" width="170" height="120" rx="8" />
          <rect x="460" y="280" width="110" height="120" rx="8" />
        </g>
        <g stroke="#ffffff" strokeWidth="18" strokeLinecap="round" fill="none">
          <path d="M0 146 H600" />
          <path d="M194 0 V420" />
          <path d="M338 0 V420" />
          <path d="M0 270 H600" />
        </g>
        <path d="M0 220 Q 180 180 300 230 T 600 190" stroke="#c9dcec" strokeWidth="10" fill="none" />
      </svg>

      <div className="absolute left-1/2 top-[42%] -translate-x-1/2 -translate-y-full">
        <span className="absolute left-1/2 top-full h-3 w-3 -translate-x-1/2 translate-y-[-6px] rounded-full bg-[#ed1450]/25 animate-ping" />
        <div className="relative flex h-14 w-14 items-center justify-center rounded-full bg-[#ed1450] text-white shadow-[0_12px_24px_rgba(237,20,80,0.4)]">
          <MapPin size={26} strokeWidth={2.2} />
        </div>
      </div>

      <div className="absolute bottom-4 left-4 right-4 rounded-xl border border-white/70 bg-white/95 p-4 shadow-[0_10px_24px_rgba(17,39,70,0.12)] backdrop-blur sm:left-6 sm:right-auto sm:max-w-[330px]">
        <p className="text-[13px] font-extrabold text-[#112746]">Variety Computer PLC</p>
        <p className="mt-1 text-[12px] leading-5 text-[#5f7590]">Bole Medhanialem, Near Friendship International Hotel, Addis Ababa, Ethiopia</p>
      </div>
    </div>
  );
}
