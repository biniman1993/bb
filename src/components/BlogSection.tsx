import { ArrowRight, CalendarDays, UserRound } from 'lucide-react';
import { blogPosts } from '@/lib/blogPosts';

export function BlogSection() {
  return (
    <section id="blog" className="blog-section bg-[#f8fafc] px-6 py-20 text-[#112746] sm:px-10 sm:py-24 lg:px-12">
      <div className="mx-auto max-w-[1400px]">
        <div className="text-center reveal-up">
          <p className="section-kicker">Our Blogs</p>
          <h2 className="mt-2 text-[34px] font-extrabold tracking-[-0.06em] sm:text-[48px]">Latest News &amp; Insights</h2>
          <p className="mx-auto mt-3 max-w-[650px] text-[15px] leading-7 text-[#7287a1]">Technology tips, product updates, and helpful insights for your business.</p>
          <span className="mx-auto mt-4 block h-[3px] w-20 bg-[#ed1450]" />
        </div>

        <div className="blog-grid mt-8">
          {blogPosts.map(({ slug, category, title, date, image, icon: Icon }, index) => (
            <a key={slug} href={`#blog/${slug}`} className="blog-card reveal-up group block" style={{ animationDelay: `${index * 80}ms` }}>
              <div className="blog-image-wrap">
                <img src={image} alt={title} className="blog-image" />
                <span className="blog-image-shade" />
              </div>
              <div className="p-4 pb-5 sm:p-5 sm:pb-6">
                <div className="blog-category"><Icon size={15} strokeWidth={2.4} /><span>{category}</span></div>
                <h3 className="mt-3 text-[18px] font-extrabold leading-6 tracking-[-0.025em] text-[#112f5a] sm:text-[19px]">{title}</h3>
                <div className="mt-5 flex items-center gap-3 border-t border-[#e4ebf2] pt-4 text-[12px] text-[#7287a1]">
                  <span className="inline-flex items-center gap-1.5"><UserRound size={16} className="text-[#ed1450]" />Variety Computer PLC</span>
                  <span className="h-4 w-px bg-[#dbe4ed]" />
                  <span className="inline-flex items-center gap-1.5"><CalendarDays size={16} className="text-[#ed1450]" />{date}</span>
                </div>
                <span className="mt-4 inline-flex items-center gap-1.5 text-[13px] font-bold text-[#ed1450] transition-colors group-hover:text-[#c90d42]">
                  Read Article <ArrowRight size={15} className="transition-transform group-hover:translate-x-1" />
                </span>
              </div>
            </a>
          ))}
        </div>
      </div>
    </section>
  );
}
