import Image from "next/image";

export default function Home() {
  return (
    <div className="min-h-screen bg-black text-white">
      {/* Header */}
      <header className="fixed w-full bg-black/80 backdrop-blur-sm border-b border-white/10">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center">
              <span className="text-2xl font-bold bg-gradient-to-r from-white to-white/80 bg-clip-text text-transparent">
                HUSH
              </span>
            </div>
            <nav className="hidden md:flex space-x-8">
              <a href="#services" className="text-white/80 hover:text-white transition-colors">Services</a>
              <a href="#about" className="text-white/80 hover:text-white transition-colors">About</a>
              <a href="#contact" className="text-white/80 hover:text-white transition-colors">Contact</a>
            </nav>
            <button className="bg-white text-black px-6 py-2 rounded-full font-medium hover:bg-white/90 transition-colors">
              Get Started
            </button>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <section className="pt-32 pb-20 px-4 sm:px-6 lg:px-8">
        <div className="max-w-7xl mx-auto">
          <div className="text-center">
            <h1 className="text-5xl md:text-6xl font-bold mb-6 bg-gradient-to-r from-white to-white/80 bg-clip-text text-transparent">
              Elevate Your Business with Secret Shopping
            </h1>
            <p className="text-xl text-white/70 mb-8 max-w-3xl mx-auto">
              Uncover the truth about your customer experience with our professional secret shopping services. 
              Get actionable insights to improve your business performance.
            </p>
            <div className="flex justify-center gap-4">
              <button className="bg-white text-black px-8 py-3 rounded-full font-medium hover:bg-white/90 transition-colors">
                Start Assessment
              </button>
              <button className="border border-white/20 px-8 py-3 rounded-full font-medium hover:bg-white/10 transition-colors">
                Learn More
              </button>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-20 px-4 sm:px-6 lg:px-8 bg-black/50">
        <div className="max-w-7xl mx-auto">
          <h2 className="text-3xl font-bold text-center mb-12">Our Services</h2>
          <div className="grid md:grid-cols-3 gap-8">
            {[
              {
                title: "Mystery Shopping",
                description: "Professional shoppers evaluate your business from a customer's perspective"
              },
              {
                title: "Detailed Reports",
                description: "Comprehensive insights and actionable recommendations"
              },
              {
                title: "Quality Control",
                description: "Ensure consistent service quality across all locations"
              }
            ].map((feature, index) => (
              <div key={index} className="p-6 rounded-lg border border-white/10 hover:border-white/20 transition-colors">
                <h3 className="text-xl font-semibold mb-3">{feature.title}</h3>
                <p className="text-white/70">{feature.description}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-white/10 py-12 px-4 sm:px-6 lg:px-8">
        <div className="max-w-7xl mx-auto">
          <div className="grid md:grid-cols-4 gap-8">
            <div>
              <h3 className="text-xl font-bold mb-4">HUSH</h3>
              <p className="text-white/70">Elevating business performance through professional secret shopping services.</p>
            </div>
            <div>
              <h4 className="font-semibold mb-4">Services</h4>
              <ul className="space-y-2 text-white/70">
                <li><a href="#" className="hover:text-white transition-colors">Mystery Shopping</a></li>
                <li><a href="#" className="hover:text-white transition-colors">Quality Assessment</a></li>
                <li><a href="#" className="hover:text-white transition-colors">Performance Reports</a></li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold mb-4">Company</h4>
              <ul className="space-y-2 text-white/70">
                <li><a href="#" className="hover:text-white transition-colors">About Us</a></li>
                <li><a href="#" className="hover:text-white transition-colors">Contact</a></li>
                <li><a href="#" className="hover:text-white transition-colors">Careers</a></li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold mb-4">Contact</h4>
              <ul className="space-y-2 text-white/70">
                <li>info@hush.com</li>
                <li>1-800-HUSH</li>
              </ul>
            </div>
          </div>
          <div className="mt-12 pt-8 border-t border-white/10 text-center text-white/50">
            <p>&copy; {new Date().getFullYear()} Hush. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </div>
  );
}
