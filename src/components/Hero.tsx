import { ArrowRight, Search } from 'lucide-react';
import { HeroTextRotator } from './HeroTextRotator';
import { Navbar } from './Navbar';
import { SearchTypewriter } from './SearchTypewriter';
import { SocialRail } from './SocialRail';

export function Hero() {
  return (
    <main id="home" className="relative min-h-screen overflow-hidden bg-[#05070a] text-white">
      <div className="absolute inset-0 bg-[url('https://images.pexels.com/photos/37698747/pexels-photo-37698747.jpeg?auto=compress&cs=tinysrgb&h=650&w=940')] bg-cover bg-center" />
      <div className="absolute inset-0 bg-[linear-gradient(180deg,rgba(1,4,7,0.89)_0%,rgba(2,5,8,0.68)_34%,rgba(2,5,8,0.54)_59%,rgba(2,4,7,0.88)_100%)]" />
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_center,rgba(0,0,0,0.12)_0%,rgba(0,0,0,0.55)_100%)]" />
      <Navbar />
      <section className="relative z-10 mx-auto flex min-h-screen max-w-[1100px] items-center justify-center px-6 pb-5 pt-32 text-center sm:pt-24">
        <div className="-mt-1 flex w-full flex-col items-center">
          <p className="mb-1 text-[46px] font-extrabold leading-none tracking-[-0.055em] text-[#f10e13] sm:text-[64px] md:text-[76px]">Welcome</p>
          <h1 className="max-w-[1000px] text-[42px] font-extrabold leading-[0.98] tracking-[-0.065em] text-white sm:text-[62px] md:text-[74px] lg:text-[78px]">To Variety Computer PLC</h1>
          <HeroTextRotator />
          <div className="mt-10 flex h-10 w-full max-w-[405px] items-center rounded-full border-2 border-white px-4 text-left shadow-[0_4px_20px_rgba(0,0,0,0.25)] sm:mt-12">
            <Search size={20} strokeWidth={2.2} className="mr-3 shrink-0" />
            <SearchTypewriter />
          </div>
          <a href="#products-range" className="group mt-7 inline-flex min-w-[182px] items-center justify-center gap-2 rounded-full bg-[#ef0b10] px-7 py-2.5 text-[17px] font-extrabold shadow-[0_8px_24px_rgba(239,11,16,0.24)] transition-all hover:scale-105 hover:bg-[#ff2428]">
            Explore More
            <ArrowRight size={18} className="transition-transform group-hover:translate-x-1" />
          </a>
        </div>
      </section>
      <SocialRail />
      <div className="absolute bottom-0 left-0 right-0 z-10 h-24 bg-gradient-to-t from-[#030507] to-transparent" />
    </main>
  );
}
