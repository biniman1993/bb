import { useEffect, useState } from 'react';

const phrases = ['computers', 'printers', 'networking equipment', 'accessories'];

const TYPE_MS = 90;
const DELETE_MS = 45;
const HOLD_MS = 1600;
const PAUSE_MS = 350;

export function SearchTypewriter() {
  const [index, setIndex] = useState(0);
  const [text, setText] = useState('');
  const [deleting, setDeleting] = useState(false);

  useEffect(() => {
    const word = phrases[index];
    const finishedTyping = !deleting && text === word;
    const finishedDeleting = deleting && text === '';

    const delay = finishedTyping ? HOLD_MS : finishedDeleting ? PAUSE_MS : deleting ? DELETE_MS : TYPE_MS;

    const timer = window.setTimeout(() => {
      if (finishedTyping) {
        setDeleting(true);
      } else if (finishedDeleting) {
        setDeleting(false);
        setIndex((current) => (current + 1) % phrases.length);
      } else {
        setText(word.slice(0, deleting ? text.length - 1 : text.length + 1));
      }
    }, delay);

    return () => window.clearTimeout(timer);
  }, [text, deleting, index]);

  return (
    <span className="flex min-w-0 items-center truncate text-[14px] font-semibold tracking-[-0.01em] text-white" aria-label={phrases[index]}>
      <span className="truncate">{text}</span>
      <span className="ml-0.5 inline-block h-4 w-[2px] shrink-0 animate-pulse bg-white" aria-hidden="true" />
    </span>
  );
}
