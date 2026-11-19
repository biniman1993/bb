import { BlogSection } from '@/components/BlogSection';
import { BrandsSection } from '@/components/BrandsSection';
import { FeatureSection } from '@/components/FeatureSection';
import { Footer } from '@/components/Footer';
import { Hero } from '@/components/Hero';
import { ProductsSection } from '@/components/ProductsSection';
import { ServicesSection } from '@/components/ServicesSection';
import { TestimonialsSection } from '@/components/TestimonialsSection';

export function Home() {
  return (
    <>
      <Hero />
      <FeatureSection />
      <ServicesSection />
      <ProductsSection />
      <TestimonialsSection />
      <BrandsSection />
      <BlogSection />
      <Footer />
    </>
  );
}
