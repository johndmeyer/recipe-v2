import { render, screen } from '@testing-library/react';
import App from './App';

test('renders app title `..-recipe-..`', () => {
  render(<App />);
  const linkElement = screen.getByText(/..-recipe-../i);
  expect(linkElement).toBeInTheDocument();
});
