import { Laptop, Monitor, Network, Printer, Server } from 'lucide-react';
import type { ComponentType } from 'react';
import type { LucideProps } from 'lucide-react';

interface ProductItem {
  name: string;
  description: string;
  image: string;
}

interface ProductCategory {
  label: string;
  icon: ComponentType<LucideProps>;
  image: string;
  title: string;
  description: string;
  items: ProductItem[];
}

const laptopImage = 'https://images.pexels.com/photos/34140/pexels-photo.jpg?auto=compress&cs=tinysrgb&h=650&w=940';
const printerImage = 'https://images.pexels.com/photos/11833899/pexels-photo-11833899.jpeg?auto=compress&cs=tinysrgb&h=650&w=940';
const networkImage = 'https://images.pexels.com/photos/17489155/pexels-photo-17489155.jpeg?auto=compress&cs=tinysrgb&h=650&w=940';
const serverImage = 'https://images.pexels.com/photos/37730212/pexels-photo-37730212.jpeg?auto=compress&cs=tinysrgb&h=650&w=940';
const computerImage = 'https://images.pexels.com/photos/16230157/pexels-photo-16230157.jpeg?auto=compress&cs=tinysrgb&h=650&w=940';

const categories: ProductCategory[] = [
  {
    label: 'Computers', icon: Monitor, image: computerImage, title: 'Modern Computers',
    description: 'Powerful, reliable and efficient computers designed to support modern businesses, offices and professional workloads.',
    items: [
      { name: 'Desktop Computers', description: 'Reliable business desktops for offices.', image: computerImage },
      { name: 'Business PCs', description: 'Powerful and dependable systems for workplaces.', image: computerImage },
      { name: 'All-in-One PCs', description: 'Space-saving computing for modern offices.', image: computerImage },
      { name: 'Workstations', description: 'High-performance systems for demanding workloads.', image: computerImage },
      { name: 'Mini PCs', description: 'Compact and efficient business solutions.', image: computerImage },
      { name: 'Professional Displays', description: 'Quality displays for productive work.', image: computerImage },
      { name: 'Accessories', description: 'Essential peripherals for complete setups.', image: computerImage },
      { name: 'Office Computers', description: 'Reliable systems for everyday business.', image: computerImage },
    ],
  },
  {
    label: 'Laptops', icon: Laptop, image: laptopImage, title: 'Modern Laptops',
    description: 'Discover flexible and dependable laptops designed for business, education, professional work and high-performance computing.',
    items: [
      { name: 'Business Laptops', description: 'Reliable laptops designed for everyday productivity.', image: laptopImage },
      { name: 'Professional Laptops', description: 'Powerful performance for demanding workloads.', image: laptopImage },
      { name: 'High-Performance Laptops', description: 'Advanced power for intensive multitasking.', image: laptopImage },
      { name: 'Student Laptops', description: 'Practical devices for learning and study.', image: laptopImage },
      { name: 'Premium Laptops', description: 'Lightweight designs combining power and quality.', image: laptopImage },
      { name: '2-in-1 Laptops', description: 'Laptop productivity with tablet convenience.', image: laptopImage },
      { name: 'Gaming Laptops', description: 'High-performance systems for graphics-intensive work.', image: laptopImage },
      { name: 'Laptop Accessories', description: 'Essentials to complete your laptop setup.', image: laptopImage },
    ],
  },
  {
    label: 'Printers', icon: Printer, image: printerImage, title: 'Printers',
    description: 'Smart document solutions that help businesses print, scan, copy and manage documents efficiently.',
    items: [
      { name: 'Laser Printers', description: 'Fast and reliable printing for business needs.', image: printerImage },
      { name: 'Inkjet Printers', description: 'Quality color printing for offices and education.', image: printerImage },
      { name: 'Multifunction Printers', description: 'Print, scan, copy, and manage documents.', image: printerImage },
      { name: 'Heavy-Duty Copiers', description: 'High-volume printing for demanding workplaces.', image: printerImage },
      { name: 'Large Format Printers', description: 'Professional printing for graphics and designs.', image: printerImage },
      { name: 'Scanners', description: 'Reliable scanning for efficient digital workflows.', image: printerImage },
    ],
  },
  {
    label: 'Networking', icon: Network, image: networkImage, title: 'Networking',
    description: 'Build secure, reliable and scalable network infrastructure with professional networking equipment.',
    items: [
      { name: 'Network Switches', description: 'Reliable connectivity for business infrastructure.', image: networkImage },
      { name: 'Routers', description: 'Secure network connectivity for organizations.', image: networkImage },
      { name: 'Wireless Access Points', description: 'Reliable Wi-Fi for modern workplaces.', image: networkImage },
      { name: 'Firewalls & Security', description: 'Protection for your business infrastructure.', image: networkImage },
      { name: 'Network Racks & Accessories', description: 'Organized equipment for professional installations.', image: networkImage },
      { name: 'Structured Cabling', description: 'Efficient cabling for dependable connectivity.', image: networkImage },
    ],
  },
  {
    label: 'Servers', icon: Server, image: serverImage, title: 'Servers',
    description: 'Scalable computing and infrastructure solutions designed for secure, reliable and efficient business operations.',
    items: [
      { name: 'Tower Servers', description: 'Flexible servers for growing organizations.', image: serverImage },
      { name: 'Rack Servers', description: 'Space-efficient performance for data centers.', image: serverImage },
      { name: 'Storage Servers', description: 'Dependable capacity for critical business data.', image: serverImage },
      { name: 'Backup Systems', description: 'Resilient solutions for business continuity.', image: serverImage },
      { name: 'Server Racks', description: 'Professional infrastructure for organized deployments.', image: serverImage },
      { name: 'UPS & Power Protection', description: 'Keep essential systems running with confidence.', image: serverImage },
    ],
  },
];

export function ProductsSection() {
  return (
    <section id="products-range" className="overflow-hidden bg-[#f8fafc] px-6 py-20 text-[#112746] sm:px-10 sm:py-24 lg:px-12">
      <div className="mx-auto max-w-[1320px]">
        <div className="text-center reveal-up">
          <p className="products-label">Our Products</p>
          <h2 className="mt-2 text-[34px] font-extrabold tracking-[-0.06em] sm:text-[48px]">Explore Our Product Range</h2>
          <p className="mx-auto mt-3 max-w-[650px] text-[15px] leading-7 text-[#7287a1]">High-quality technology from trusted brands to meet your business needs.</p>
        </div>

        <div className="mt-12 grid gap-12">
          {categories.map((category) => {
            const Icon = category.icon;
            return (
              <div key={category.label} className="scroll-mt-24">
                <div className="mb-5 flex items-center justify-center gap-3">
                  <span className="h-8 w-1 rounded-full bg-[#ed1450]" />
                  <h3 className="text-[26px] font-extrabold tracking-[-0.04em] text-[#112746] sm:text-[32px]">{category.title}</h3>
                </div>
                <div className="grid gap-5 lg:grid-cols-[minmax(300px,0.78fr)_1.5fr]">
                  <div className="product-feature-card group reveal-left">
                    <img src={category.image} alt={category.title} className="absolute inset-0 h-full w-full object-cover transition duration-700 group-hover:scale-105" />
                    <div className="absolute inset-0 bg-[linear-gradient(180deg,rgba(3,20,48,0.04)_20%,rgba(3,18,51,0.98)_100%)]" />
                    <div className="relative z-10 mt-auto p-7 text-white sm:p-8">
                      <span className="product-feature-icon"><Icon size={27} /></span>
                      <h4 className="mt-4 text-[29px] font-extrabold tracking-[-0.04em]">{category.title}</h4>
                      <span className="mt-3 block h-[3px] w-12 bg-[#ed1450]" />
                      <p className="mt-4 max-w-[310px] text-[15px] leading-7 text-white/85">{category.description}</p>
                    </div>
                  </div>
                  <div className="product-grid">
                    {category.items.map((item, index) => (
                      <article key={item.name} className="product-item reveal-up" style={{ animationDelay: `${index * 55}ms` }}>
                        <div className="product-item-image"><img src={item.image} alt="" /></div>
                        <div className="min-w-0 text-left">
                          <h4 className="text-[15px] font-extrabold leading-5 text-[#112746]">{item.name}</h4>
                          <p className="mt-2 text-[13px] leading-5 text-[#70859f]">{item.description}</p>
                        </div>
                      </article>
                    ))}
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
