import { Send } from 'lucide-react';

export function BrandMark() {
  return (
    <a href="#home" className="flex items-center gap-3" aria-label="Variety Computer home">
      <span className="flex h-8 w-8 items-center justify-center rounded-full bg-white text-[#ed1717] shadow-[0_0_18px_rgba(255,255,255,0.12)] sm:h-9 sm:w-9">
        <Send size={18} strokeWidth={2.5} className="-rotate-12" />
      </span>
      <span className="text-[20px] font-medium tracking-[-0.03em] text-white sm:text-[24px]">
        Variety <span className="text-[#f00b12]">Computer</span>
      </span>
    </a>
  );
}
