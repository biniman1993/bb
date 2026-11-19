import { ArrowLeft, ArrowRight, CalendarDays, Clock3, UserRound } from 'lucide-react';
import { Footer } from '@/components/Footer';
import { Navbar } from '@/components/Navbar';
import { CONTACT_HASH } from '@/lib/routes';
import type { BlogContentBlock, BlogPost } from '@/lib/blogPosts';
import { blogPosts } from '@/lib/blogPosts';

function ContentBlock({ block }: { block: BlogContentBlock }) {
  switch (block.type) {
    case 'heading':
      return <h2 className="mt-12 text-[26px] font-extrabold leading-tight tracking-[-0.03em] text-[#112746] sm:text-[30px]">{block.text}</h2>;
    case 'paragraph':
      return <p className="mt-5 text-[17px] leading-8 text-[#425a76]">{block.text}</p>;
    case 'list':
      return (
        <ul className="mt-5 grid gap-3">
          {block.items?.map((item, index) => (
            <li key={index} className="flex gap-3 text-[16px] leading-7 text-[#425a76]">
              <span className="mt-2.5 h-1.5 w-1.5 shrink-0 rounded-full bg-[#ed1450]" />
              <span>{item}</span>
            </li>
          ))}
        </ul>
      );
    case 'callout':
      return (
        <div className="mt-10 rounded-2xl border-l-4 border-[#ed1450] bg-[#ed1450]/[0.06] p-6 sm:p-8">
          <p className="text-[17px] font-semibold leading-8 text-[#112746]">{block.text}</p>
        </div>
      );
    case 'table':
      return (
        <div className="mt-7 overflow-x-auto rounded-2xl border border-[#e4ebf2] shadow-[0_8px_22px_rgba(7,26,53,0.06)]">
          <table className="w-full border-collapse text-left text-[15px]">
            <thead>
              <tr className="bg-[#071a35] text-white">
                {block.headers?.map((header) => (
                  <th key={header} className="px-5 py-4 font-extrabold tracking-[-0.01em]">{header}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {block.rows?.map((row, rowIndex) => (
                <tr key={rowIndex} className={rowIndex % 2 === 0 ? 'bg-white' : 'bg-[#f8fafc]'}>
                  {row.map((cell, cellIndex) => (
                    <td key={cellIndex} className="border-t border-[#e4ebf2] px-5 py-4 text-[#425a76]">{cell}</td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      );
    default:
      return null;
  }
}

export function BlogDetailPage({ post }: { post: BlogPost }) {
  const { category, title, date, readingTime, image, icon: Icon, intro, content, ctaText, ctaLink } = post;
  const related = blogPosts.filter((p) => p.slug !== post.slug).slice(0, 3);

  return (
    <main className="min-h-screen bg-[#f8fafc] text-[#112746]">
      <section className="relative overflow-hidden bg-[#071a35] pb-20 pt-40 text-white sm:pb-24 sm:pt-44">
        <img src={image} alt="" className="absolute inset-0 h-full w-full object-cover opacity-25" />
        <div className="absolute inset-0 bg-[linear-gradient(180deg,rgba(7,26,53,0.6)_0%,rgba(7,26,53,0.93)_100%)]" />
        <div className="absolute inset-x-0 top-0 h-[3px] bg-[#ed1450]" />
        <div className="relative z-10 mx-auto max-w-[800px] px-6 text-center reveal-up">
          <div className="inline-flex items-center gap-2 rounded-full border border-white/20 bg-white/10 px-4 py-1.5 text-[12px] font-bold uppercase tracking-[0.15em] text-white">
            <Icon size={14} strokeWidth={2.4} /> {category}
          </div>
          <h1 className="mt-5 text-[34px] font-extrabold leading-[1.12] tracking-[-0.05em] sm:text-[46px]">{title}</h1>
          <div className="mt-6 flex flex-wrap items-center justify-center gap-5 text-[13px] text-white/80">
            <span className="inline-flex items-center gap-2"><UserRound size={16} className="text-[#ff789c]" /> Variety Computer PLC</span>
            <span className="inline-flex items-center gap-2"><CalendarDays size={16} className="text-[#ff789c]" /> {date}</span>
            <span className="inline-flex items-center gap-2"><Clock3 size={16} className="text-[#ff789c]" /> {readingTime}</span>
          </div>
        </div>
        <Navbar />
      </section>

      <article className="relative z-10 mx-auto -mt-10 max-w-[820px] px-6 sm:px-8">
        <div className="rounded-2xl bg-white p-7 shadow-[0_18px_44px_rgba(7,26,53,0.10)] sm:p-10">
          <p className="text-[18px] leading-8 font-medium text-[#112746]">{intro}</p>
          {content.map((block, index) => (
            <ContentBlock key={index} block={block} />
          ))}
          <div className="mt-12 flex flex-wrap gap-3 border-t border-[#e4ebf2] pt-8">
            <a href={ctaLink} className="group inline-flex items-center gap-2 rounded-md bg-[#ed1450] px-6 py-3 text-[14px] font-extrabold text-white shadow-[0_12px_24px_rgba(237,20,80,0.18)] transition-all hover:-translate-y-1 hover:bg-[#c90d42]">
              {ctaText} <ArrowRight size={16} className="transition-transform group-hover:translate-x-1" />
            </a>
            <a href={CONTACT_HASH} className="inline-flex items-center gap-2 rounded-md border-2 border-[#ed1450] px-6 py-3 text-[14px] font-extrabold text-[#ed1450] transition-all hover:-translate-y-1 hover:bg-[#ed1450]/5">
              Contact Our Team
            </a>
          </div>
        </div>
      </article>

      <section className="mx-auto max-w-[820px] px-6 py-16 sm:px-8">
        <a href="#blog" className="inline-flex items-center gap-2 text-[14px] font-bold text-[#ed1450] transition-colors hover:text-[#c90d42]">
          <ArrowLeft size={16} /> Back to All Articles
        </a>
      </section>

      <section className="bg-white px-6 py-16 sm:px-10 sm:py-20 lg:px-12">
        <div className="mx-auto max-w-[1320px]">
          <div className="text-center reveal-up">
            <p className="section-kicker">Keep Reading</p>
            <h2 className="mt-2 text-[28px] font-extrabold tracking-[-0.05em] sm:text-[36px]">Related Articles</h2>
            <span className="mx-auto mt-4 block h-[3px] w-20 bg-[#ed1450]" />
          </div>
          <div className="mt-10 grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {related.map(({ slug, category: cat, title: t, image: img, icon: RelIcon, date: d }) => (
              <a key={slug} href={`#blog/${slug}`} className="group overflow-hidden rounded-2xl border border-[#e4ebf2] bg-white shadow-[0_8px_22px_rgba(7,26,53,0.06)] transition-all hover:-translate-y-1.5 hover:shadow-[0_18px_36px_rgba(7,26,53,0.12)]">
                <div className="relative h-44 overflow-hidden">
                  <img src={img} alt={t} className="h-full w-full object-cover transition duration-700 group-hover:scale-110" />
                  <div className="absolute inset-0 bg-gradient-to-t from-[#071a35]/70 to-transparent" />
                  <span className="absolute left-4 top-4 inline-flex items-center gap-1.5 rounded-full bg-[#ed1450] px-3 py-1 text-[11px] font-bold uppercase tracking-wide text-white"><RelIcon size={12} strokeWidth={2.4} /> {cat}</span>
                </div>
                <div className="p-5">
                  <h3 className="text-[16px] font-extrabold leading-6 tracking-[-0.02em] text-[#112f5a]">{t}</h3>
                  <p className="mt-3 text-[12px] text-[#7287a1]">{d}</p>
                </div>
              </a>
            ))}
          </div>
        </div>
      </section>

      <Footer />
    </main>
  );
}
