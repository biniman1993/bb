import { useEffect, useState } from 'react';
import type { CSSProperties } from 'react';
import { ChevronLeft, ChevronRight, Quote, Star } from 'lucide-react';

const testimonials = [
  {
    organization: 'Ethiopian Airlines',
    department: 'IT Department',
    mark: 'EA',
    quote: 'Variety Computer has been our trusted technology partner. Their team provided excellent support and delivered high-quality equipment on time.',
  },
  {
    organization: 'Ministry of Health',
    department: 'ICT Directorate',
    mark: 'MH',
    quote: 'We are very satisfied with the quality of products and the professional service provided by Variety Computer. They always respond quickly to our needs.',
  },
  {
    organization: 'Addis Ababa City Administration',
    department: 'IT Department',
    mark: 'AA',
    quote: 'Variety Computer demonstrated strong technical knowledge and delivered the required equipment professionally and on time. We highly recommend them.',
  },
  {
    organization: 'Federal Supreme Court',
    department: 'IT Department',
    mark: 'SC',
    quote: 'Their expertise, commitment, and reliable support have made a great difference in our operations. Variety Computer is a company we can count on.',
  },
  {
    organization: 'Education Bureau',
    department: 'Technology Office',
    mark: 'EB',
    quote: 'The team made a complex technology rollout feel simple, organized, and dependable from the first conversation through delivery.',
  },
  {
    organization: 'Public Enterprise',
    department: 'Procurement Department',
    mark: 'PE',
    quote: 'Reliable equipment, clear communication, and responsive after-sales support make Variety Computer a valuable partner for our organization.',
  },
];

export function TestimonialsSection() {
  const [slide, setSlide] = useState(0);
  const maxSlide = testimonials.length - 4;

  useEffect(() => {
    const timer = window.setInterval(() => {
      setSlide((current) => (current >= maxSlide ? 0 : current + 1));
    }, 5500);

    return () => window.clearInterval(timer);
  }, [maxSlide]);

  return (
    <section id="testimonials" className="relative overflow-hidden bg-[#edf5fc] px-6 py-20 text-[#12345d] sm:px-10 sm:py-24 lg:px-12">
      <div className="absolute inset-0 bg-[url('https://images.pexels.com/photos/8310949/pexels-photo-8310949.jpeg?auto=compress&cs=tinysrgb&h=650&w=940')] bg-cover bg-center opacity-[0.13]" />
      <div className="absolute inset-0 bg-[linear-gradient(90deg,rgba(245,250,255,0.95),rgba(245,250,255,0.74),rgba(245,250,255,0.95))]" />
      <div className="relative mx-auto max-w-[1320px]">
        <div className="text-center reveal-up">
          <p className="section-kicker">What Our Clients Say</p>
          <h2 className="mx-auto mt-3 max-w-[850px] text-[31px] font-extrabold leading-[1.12] tracking-[-0.055em] sm:text-[45px]">Trusted by Organizations for Quality Technology and Reliable Service.</h2>
          <span className="mx-auto mt-5 block h-[3px] w-20 bg-[#ed1450]" />
        </div>

        <div className="testimonial-stage mt-12">
          <button type="button" onClick={() => setSlide((current) => current <= 0 ? maxSlide : current - 1)} className="testimonial-control testimonial-control-left" aria-label="Previous testimonials">
            <ChevronLeft size={24} />
          </button>
          <div className="testimonial-viewport">
            <div className="testimonial-track" style={{ '--testimonial-slide': slide } as CSSProperties}>
              {testimonials.map((testimonial) => (
                <article key={testimonial.organization} className="testimonial-card group">
                  <div className="flex items-center gap-3">
                    <span className="organization-mark">{testimonial.mark}</span>
                    <div className="text-left">
                      <h3 className="text-[14px] font-extrabold leading-5 text-[#12345d]">{testimonial.organization}</h3>
                      <p className="text-[12px] text-[#7287a1]">Technology partner</p>
                    </div>
                  </div>
                  <Quote size={32} fill="currentColor" className="mt-5 text-[#ed1450] opacity-95" />
                  <p className="mt-1 text-left text-[14px] leading-6 text-[#34557b]">{testimonial.quote}</p>
                  <div className="mt-5 flex items-end justify-between border-t border-[#dce6ef] pt-4">
                    <div className="text-left">
                      <p className="text-[12px] font-extrabold text-[#12345d]">{testimonial.organization}</p>
                      <p className="mt-1 text-[11px] text-[#7287a1]">{testimonial.department}</p>
                    </div>
                    <span className="flex gap-0.5 text-[#ed1450]" aria-label="5 out of 5 stars">
                      {Array.from({ length: 5 }).map((_, index) => <Star key={index} size={14} fill="currentColor" strokeWidth={1.5} />)}
                    </span>
                  </div>
                </article>
              ))}
            </div>
          </div>
          <button type="button" onClick={() => setSlide((current) => current >= maxSlide ? 0 : current + 1)} className="testimonial-control testimonial-control-right" aria-label="Next testimonials">
            <ChevronRight size={24} />
          </button>
        </div>

        <div className="mt-8 flex justify-center gap-2" aria-label="Testimonial slides">
          {Array.from({ length: maxSlide + 1 }).map((_, index) => (
            <button key={index} type="button" onClick={() => setSlide(index)} aria-label={`Show testimonial group ${index + 1}`} className={`testimonial-dot ${index === slide ? 'testimonial-dot-active' : ''}`} />
          ))}
        </div>

        <div className="mt-9 flex justify-center">
          <a href="#contact-us" className="inline-flex items-center justify-center rounded-full bg-[#ed1450] px-7 py-3 text-sm font-extrabold text-white shadow-[0_10px_24px_rgba(237,20,80,0.2)] transition hover:-translate-y-0.5 hover:bg-[#d90f46]">
            Explore Our Projects
          </a>
        </div>
      </div>
    </section>
  );
}
