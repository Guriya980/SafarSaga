<%-- shared_tours_style.jsp: Inline critical CSS shared by all 3 tour pages --%>
<style>
/* ── RESET & BASE ── */
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth}
body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;background:#f4f7f6;color:#1a1a2e;-webkit-font-smoothing:antialiased}
img{max-width:100%;display:block}
a{text-decoration:none}

/* ── NAVBAR (Bootstrap uses its own) ── */

/* ── HERO BASE ── */
.tours-hero{position:relative;min-height:420px;display:flex;align-items:center;overflow:hidden}
.tours-hero .hero-bg{position:absolute;inset:0;background-size:cover;background-position:center;transform:scale(1.05)}
.tours-hero .hero-overlay{position:absolute;inset:0}
.tours-hero .hero-body{position:relative;z-index:2;width:100%;padding:4rem 0}
.hero-eyebrow{display:inline-flex;align-items:center;gap:7px;background:rgba(255,255,255,.13);backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,.22);color:#a8e6cf;border-radius:100px;padding:.38rem 1.1rem;font-size:.78rem;font-weight:700;letter-spacing:.4px;margin-bottom:1.2rem}
.hero-h1{font-size:clamp(2rem,5vw,3.4rem);font-weight:800;color:#fff;line-height:1.18;margin-bottom:.9rem;font-family:'Georgia',serif}
.hero-h1 em{font-style:normal;color:#a8e6cf}
.hero-sub{color:rgba(255,255,255,.72);font-size:1rem;margin-bottom:2rem;max-width:560px}
.wave-bottom{position:absolute;bottom:-1px;left:0;right:0;line-height:0;z-index:3}
.wave-bottom svg{display:block;width:100%}

/* ── SEARCH BAR ── */
.search-wrap{display:flex;max-width:580px;background:#fff;border-radius:100px;overflow:hidden;box-shadow:0 16px 48px rgba(0,0,0,.22)}
.search-wrap input{flex:1;border:none;outline:none;padding:.85rem 1.5rem;font-size:.95rem;color:#333;background:transparent}
.search-wrap input::placeholder{color:#b0b0b0}
.search-wrap button{border:none;padding:.85rem 1.8rem;font-weight:700;font-size:.9rem;color:#fff;cursor:pointer;white-space:nowrap;transition:filter .2s}
.search-wrap button:hover{filter:brightness(1.1)}

/* ── TAB NAV ── */
.tab-nav{display:flex;flex-wrap:wrap;gap:.6rem;padding:1.5rem 0 .5rem}
.tab-pill{display:inline-flex;align-items:center;gap:6px;padding:.45rem 1.2rem;border-radius:100px;border:2px solid #dde3e0;background:#fff;color:#555;font-weight:600;font-size:.83rem;transition:all .22s}
.tab-pill:hover{border-color:#1a8a7a;color:#1a8a7a}
.tab-pill.active{background:linear-gradient(135deg,#1a8a7a,#27ae60);border-color:transparent;color:#fff;box-shadow:0 6px 18px rgba(26,138,122,.32)}

/* ── STATS BAR ── */
.stats-bar{background:#fff;border-radius:16px;padding:1.2rem 2rem;box-shadow:0 2px 16px rgba(0,0,0,.06);display:flex;flex-wrap:wrap;gap:1.5rem;align-items:center;margin-bottom:2rem}
.stats-bar .stat{text-align:center;flex:1;min-width:100px}
.stat .n{font-size:1.6rem;font-weight:800;color:#1a8a7a;line-height:1}
.stat .l{font-size:.72rem;color:#888;font-weight:600;text-transform:uppercase;letter-spacing:.5px;margin-top:3px}

/* ── TOUR CARD ── */
.card-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:1.5rem}
.t-card{background:#fff;border-radius:20px;overflow:hidden;box-shadow:0 3px 16px rgba(0,0,0,.07);transition:transform .32s cubic-bezier(.4,0,.2,1),box-shadow .32s;display:flex;flex-direction:column;height:100%}
.t-card:hover{transform:translateY(-8px);box-shadow:0 18px 48px rgba(0,0,0,.13)}
.t-card-img{position:relative;height:210px;overflow:hidden;flex-shrink:0}
.t-card-img img{width:100%;height:100%;object-fit:cover;transition:transform .55s ease}
.t-card:hover .t-card-img img{transform:scale(1.07)}

/* Image fallback - solid gradient shown while img loads or on error */
.t-card-img::before{content:'';position:absolute;inset:0;background:linear-gradient(135deg,#c8e6c9,#a5d6a7);z-index:0}
.t-card-img img{position:relative;z-index:1}

.t-badge{position:absolute;top:12px;left:12px;z-index:2;padding:.28rem .8rem;border-radius:100px;font-size:.68rem;font-weight:700;text-transform:uppercase;letter-spacing:.3px}
.badge-feat{background:rgba(255,213,0,.92);color:#7a5500}
.badge-trend{background:rgba(231,76,60,.88);color:#fff}
.badge-new{background:rgba(26,138,122,.88);color:#fff}
.wishlist{position:absolute;top:12px;right:12px;z-index:2;width:34px;height:34px;border-radius:50%;background:rgba(255,255,255,.92);border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;color:#ccc;transition:all .2s;font-size:.9rem}
.wishlist:hover,.wishlist.active{color:#e74c3c;transform:scale(1.18)}
.type-lozenge{position:absolute;bottom:10px;right:10px;z-index:2;background:rgba(0,0,0,.52);backdrop-filter:blur(4px);color:#fff;border-radius:100px;padding:.22rem .7rem;font-size:.67rem;font-weight:700;letter-spacing:.3px}
.t-card-body{padding:1.3rem;flex:1;display:flex;flex-direction:column}
.t-meta{display:flex;gap:1rem;font-size:.76rem;color:#999;margin-bottom:.6rem}
.t-meta span{display:flex;align-items:center;gap:4px}
.t-meta i{color:#1a8a7a;font-size:.7rem}
.t-title{font-weight:700;font-size:.98rem;color:#1a1a2e;line-height:1.4;margin-bottom:.5rem}
.t-desc{color:#777;font-size:.82rem;line-height:1.6;flex:1;margin-bottom:1rem;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden}
.t-footer{display:flex;align-items:center;justify-content:space-between;border-top:1px solid #f2f2f2;padding-top:.9rem}
.dur-chip{display:flex;align-items:center;gap:5px;background:#f0faf7;color:#1a8a7a;border-radius:100px;padding:.3rem .85rem;font-size:.76rem;font-weight:700}
.btn-view{display:inline-flex;align-items:center;gap:5px;background:linear-gradient(135deg,#1a8a7a,#27ae60);color:#fff;border:none;border-radius:100px;padding:.45rem 1.1rem;font-size:.8rem;font-weight:700;cursor:pointer;transition:box-shadow .22s,transform .22s}
.btn-view:hover{color:#fff;transform:translateX(3px);box-shadow:0 6px 18px rgba(26,138,122,.38)}

/* ── EMPTY / NO TOURS ── */
.no-tours{text-align:center;padding:5rem 2rem;background:linear-gradient(135deg,#f0faf7,#e8f5e9);border-radius:20px}
.no-tours i{font-size:4rem;color:#a5d6a7;margin-bottom:1rem}

/* ── LOAD MORE ── */
.load-more{background:transparent;border:2px solid #1a8a7a;color:#1a8a7a;border-radius:100px;padding:.75rem 3rem;font-weight:700;font-size:.95rem;cursor:pointer;transition:all .28s;display:block;margin:2.5rem auto 0}
.load-more:hover{background:linear-gradient(135deg,#1a8a7a,#27ae60);color:#fff;border-color:transparent;box-shadow:0 8px 24px rgba(26,138,122,.3)}

/* ── FADE-IN ── */
@keyframes fadeUp{from{opacity:0;transform:translateY(22px)}to{opacity:1;transform:translateY(0)}}
.fade-in{animation:fadeUp .55s ease both}
.d1{animation-delay:.05s}.d2{animation-delay:.1s}.d3{animation-delay:.15s}.d4{animation-delay:.2s}.d5{animation-delay:.25s}.d6{animation-delay:.3s}

/* ── RESPONSIVE ── */
@media(max-width:640px){.card-grid{grid-template-columns:1fr}.tours-hero{min-height:340px}.hero-h1{font-size:1.8rem}}
</style>
