import { useEffect, useState } from 'react';
import { ABOUT_HASH, CLIENTS_HASH, CONTACT_HASH } from '@/lib/routes';
import { getBlogPost } from '@/lib/blogPosts';
import { AboutPage } from '@/pages/AboutPage';
import { BlogDetailPage } from '@/pages/BlogDetailPage';
import { ContactPage } from '@/pages/ContactPage';
import { ClientsPage } from '@/pages/ClientsPage';
import { Home } from '@/pages/Home';

const BLOG_PREFIX = '#blog/';

function App() {
  const [hash, setHash] = useState(window.location.hash);

  useEffect(() => {
    const handleHashChange = () => setHash(window.location.hash);
    window.addEventListener('hashchange', handleHashChange);
    return () => window.removeEventListener('hashchange', handleHashChange);
  }, []);

  useEffect(() => {
    if (hash === CONTACT_HASH || hash === ABOUT_HASH || hash === CLIENTS_HASH || hash.startsWith(BLOG_PREFIX)) {
      window.scrollTo({ top: 0, behavior: 'instant' });
      return;
    }
    const target = hash.slice(1);
    if (target) document.getElementById(target)?.scrollIntoView();
  }, [hash]);

  if (hash === CONTACT_HASH) return <ContactPage />;
  if (hash === ABOUT_HASH) return <AboutPage />;
  if (hash === CLIENTS_HASH) return <ClientsPage />;
  if (hash.startsWith(BLOG_PREFIX)) {
    const slug = hash.slice(BLOG_PREFIX.length);
    const post = getBlogPost(slug);
    if (post) return <BlogDetailPage post={post} />;
  }
  return <Home />;
}

export default App;
