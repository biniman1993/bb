import { useEffect, useState } from 'react';

const texts = [
  'Professional IT equipment, office technology, networking, and business solutions built to keep your organization connected and productive.',
  'All Your Technology Needs, Quality Products and Reliable Solutions in One Place.',
  'Discover the Latest Computers and Laptops Designed for Productivity and Performance.',
  'Power Your Business with Reliable Networking Equipment and Advanced Connectivity Solutions.',
  'Explore Professional Printers, High-Performance Servers and Essential Office Equipment.',
  'Complete IT Solutions to Connect, Empower and Drive Your Business Forward.',
];

const VISIBLE_MS = 4200;
const TRANSITION_MS = 500;

export function HeroTextRotator() {
  const [index, setIndex] = useState(0);
  const [leaving, setLeaving] = useState(false);

  useEffect(() => {
    const cycle = setInterval(() => {
      setLeaving(true);
      setTimeout(() => {
        setIndex((prev) => (prev + 1) % texts.length);
        setLeaving(false);
      }, TRANSITION_MS);
    }, VISIBLE_MS);
    return () => clearInterval(cycle);
  }, []);

  return (
    <div className="hero-text-rotator mt-5 max-w-[760px]">
      <p
        key={index}
        className={`hero-text-line ${leaving ? 'out' : ''} text-[17px] font-normal leading-8 text-white/95 sm:text-[20px] sm:leading-9`}
      >
        {texts[index]}
      </p>
    </div>
  );
}
