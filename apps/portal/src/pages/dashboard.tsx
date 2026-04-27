import React from 'react';

// Devopstrio AVD Image Factory
// Image Operations Command Center

const Dashboard = () => {
    return (
        <div className="min-h-screen bg-neutral-950 text-neutral-200 font-sans selection:bg-rose-500/30">
            {/* Global Operations Header */}
            <header className="border-b border-neutral-900 bg-black/50 backdrop-blur-xl sticky top-0 z-50">
                <div className="max-w-screen-2xl mx-auto px-8 h-20 flex items-center justify-between">
                    <div className="flex items-center gap-6">
                        <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-rose-600 to-orange-600 flex items-center justify-center font-black text-white shadow-[0_0_20px_rgba(225,29,72,0.4)] border border-white/10">
                            IF
                        </div>
                        <div>
                            <h1 className="text-xl font-black text-white tracking-tight">IMAGE FACTORY</h1>
                            <p className="text-[10px] font-bold text-rose-400 uppercase tracking-widest leading-none mt-1">Golden Image Control Plane</p>
                        </div>
                    </div>
                    <nav className="flex gap-8 text-[11px] font-bold uppercase tracking-widest text-neutral-500">
                        <a href="#" className="text-rose-400 border-b-2 border-rose-500 pb-8 pt-8">Fleet Status</a>
                        <a href="#" className="hover:text-white transition-colors pt-8 pb-8">Build Center</a>
                        <a href="#" className="hover:text-white transition-colors pt-8 pb-8">Test Rails</a>
                        <a href="#" className="hover:text-white transition-colors pt-8 pb-8">Distribution</a>
                        <a href="#" className="hover:text-white transition-colors pt-8 pb-8">SLA Analytics</a>
                    </nav>
                </div>
            </header>

            <main className="max-w-screen-2xl mx-auto px-8 py-10">

                {/* Image Lifecycle KPI Scorecards */}
                <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-12">
                    {[
                        { label: 'Build Success Rate', value: '98.5%', change: 'Last 90 Days', color: 'emerald' },
                        { label: 'Patch Compliance', value: '100%', change: 'Apr 2026 Ring', color: 'blue' },
                        { label: 'Avg. Build Time', value: '42m', change: '-4m vs last month', color: 'rose' },
                        { label: 'Catalog Versions', value: '142', change: '8 Actively Used', color: 'neutral' }
                    ].map((kpi, idx) => (
                        <div key={idx} className="bg-neutral-900/50 p-8 rounded-3xl border border-neutral-800 hover:border-rose-500/30 transition-all shadow-xl group relative overflow-hidden">
                            <div className={`absolute -right-8 -bottom-8 w-24 h-24 bg-${kpi.color}-500/5 rounded-full blur-2xl`}></div>
                            <span className="text-[10px] font-bold text-neutral-500 uppercase tracking-widest leading-none">{kpi.label}</span>
                            <div className="text-3xl font-black text-white mt-3 font-mono tracking-tighter">{kpi.value}</div>
                            <div className={`text-[10px] mt-4 font-bold ${kpi.color === 'emerald' ? 'text-emerald-400' : 'text-neutral-400'} flex items-center gap-2 uppercase tracking-widest`}>
                                <span className={`w-1.5 h-1.5 rounded-full ${kpi.color === 'emerald' ? 'bg-emerald-400' : 'bg-neutral-600'}`}></span>
                                {kpi.change}
                            </div>
                        </div>
                    ))}
                </div>

                {/* Primary Intelligence Grid */}
                <div className="grid grid-cols-1 xl:grid-cols-3 gap-10">

                    {/* Build Pipeline Status Placeholder */}
                    <div className="xl:col-span-2 bg-neutral-900 p-10 rounded-[2.5rem] border border-neutral-800 shadow-2xl relative overflow-hidden">
                        <div className="absolute top-0 right-0 w-96 h-96 bg-rose-600/5 rounded-full blur-[100px] -translate-y-1/2 translate-x-1/2"></div>
                        <div className="flex justify-between items-center mb-10">
                            <div>
                                <h2 className="text-2xl font-black text-white tracking-tight">Active Operation Pipelines</h2>
                                <p className="text-neutral-400 text-sm mt-1">Real-time status of Packer build agents and replication jobs.</p>
                            </div>
                            <div className="flex items-center gap-2 px-4 py-2 bg-black/40 rounded-xl border border-neutral-700 text-[10px] font-bold text-neutral-400 uppercase tracking-widest">
                                <span className="w-2 h-2 bg-rose-500 rounded-full animate-pulse shadow-[0_0_10px_rgba(225,29,72,0.8)]"></span>
                                3 Jobs Running
                            </div>
                        </div>

                        <div className="space-y-6">
                            {[
                                { name: 'Win11-Multisession-Finance', step: 'CIS Hardening', prog: 65, status: 'In-Progress' },
                                { name: 'GPU-Eng-Workstation', step: 'Application Layering', prog: 82, status: 'In-Progress' },
                                { name: 'Contractor-Sec-Image', step: 'Sysprep & Capture', prog: 94, status: 'Finalizing' },
                                { name: 'CallCenter-Basic-V2', step: 'Validation Test', prog: 100, status: 'Post-Build' }
                            ].map((job, idx) => (
                                <div key={idx} className="bg-black/40 p-6 rounded-2xl border border-white/5 relative group hover:border-rose-500/20 transition-all">
                                    <div className="flex justify-between items-center mb-4">
                                        <div className="font-bold text-white tracking-tight">{job.name}</div>
                                        <div className="text-[10px] font-black text-rose-400 uppercase tracking-widest">{job.status}</div>
                                    </div>
                                    <div className="flex justify-between text-[10px] font-bold text-neutral-500 uppercase tracking-wider mb-2">
                                        <span>Step: {job.step}</span>
                                        <span>{job.prog}%</span>
                                    </div>
                                    <div className="w-full bg-neutral-800 h-1.5 rounded-full overflow-hidden">
                                        <div className="bg-gradient-to-r from-rose-600 to-orange-500 h-full transition-all duration-500" style={{ width: `${job.prog}%` }}></div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>

                    {/* Regional Replication Monitor */}
                    <div className="bg-neutral-900 rounded-[2.5rem] border border-neutral-800 p-10 shadow-2xl flex flex-col justify-between group">
                        <div>
                            <h3 className="text-lg font-black text-white uppercase tracking-wider mb-6 border-b border-white/5 pb-4">Global Replication</h3>
                            <div className="space-y-8">
                                {[
                                    { region: 'US East 2', latency: '4ms', sync: '100%', status: 'Synced' },
                                    { region: 'UK South', latency: '1ms', sync: '100%', status: 'Primary' },
                                    { region: 'West Europe', latency: '8ms', sync: '100%', status: 'Synced' },
                                    { region: 'Japan East', latency: '142ms', sync: '88%', status: 'Syncing' }
                                ].map((reg, rIdx) => (
                                    <div key={rIdx} className="flex items-center justify-between">
                                        <div className="flex items-center gap-4">
                                            <div className={`w-2 h-2 rounded-full ${reg.sync === '100%' ? 'bg-emerald-500 shadow-[0_0_10px_rgba(16,185,129,0.5)]' : 'bg-rose-500 animate-pulse'}`}></div>
                                            <div>
                                                <div className="text-sm font-bold text-white">{reg.region}</div>
                                                <div className="text-[9px] text-neutral-500 font-bold uppercase tracking-widest">{reg.status}</div>
                                            </div>
                                        </div>
                                        <div className="text-right">
                                            <div className="text-xs font-black text-neutral-200 font-mono">{reg.sync}</div>
                                            <div className="text-[9px] text-neutral-600 font-bold uppercase">{reg.latency}</div>
                                        </div>
                                    </div>
                                ))}
                            </div>
                        </div>

                        <div className="mt-12 p-6 bg-rose-500/5 rounded-3xl border border-rose-500/10">
                            <p className="text-[11px] text-neutral-400 font-medium leading-relaxed italic">
                                "Global image replication typically completes within 18 minutes post-build for GRS enabled galleries."
                            </p>
                        </div>
                    </div>

                </div>

                {/* Automation & Compliance Insight */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-10 mt-12">
                    <div className="bg-neutral-900 p-8 rounded-3xl border border-neutral-800 shadow-xl overflow-hidden relative">
                        <div className="absolute -right-20 -bottom-20 w-64 h-64 bg-rose-600/5 rounded-full blur-[80px]"></div>
                        <h4 className="text-[10px] font-black text-neutral-500 uppercase tracking-widest mb-6">Patch Ring Compliance</h4>
                        <div className="space-y-4">
                            {[
                                { label: 'Ring 0 (Canary)', val: '100%', color: 'bg-emerald-500' },
                                { label: 'Ring 1 (Pilot)', val: '100%', color: 'bg-emerald-500' },
                                { label: 'Ring 2 (Production A)', val: '92%', color: 'bg-blue-500' },
                                { label: 'Ring 3 (Broad)', val: '45%', color: 'bg-neutral-700' }
                            ].map((ring, idx) => (
                                <div key={idx}>
                                    <div className="flex justify-between text-[9px] font-black text-neutral-500 uppercase tracking-tight mb-1">
                                        <span>{ring.label}</span>
                                        <span>{ring.val}</span>
                                    </div>
                                    <div className="w-full bg-black/40 h-1.5 rounded-full overflow-hidden border border-white/5">
                                        <div className={`${ring.color} h-full transition-all duration-1000`} style={{ width: ring.val }}></div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>

                    <div className="bg-neutral-900 p-8 rounded-3xl border border-neutral-800 shadow-xl flex flex-col justify-between">
                        <div className="flex justify-between items-center mb-6">
                            <h4 className="text-[10px] font-black text-neutral-500 uppercase tracking-widest">Synthetic Validation Center</h4>
                            <span className="text-[10px] font-bold text-rose-400 bg-rose-500/10 px-3 py-1 rounded-full uppercase border border-rose-500/20">Active Testing</span>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                            <div className="p-4 bg-black/20 rounded-2xl border border-white/5">
                                <div className="text-[11px] font-bold text-neutral-500 uppercase mb-2 leading-none">Login Duration</div>
                                <div className="text-2xl font-black text-white font-mono tracking-tighter">14.2s</div>
                                <div className="text-[9px] text-emerald-400 font-bold uppercase mt-2">Optimal Result</div>
                            </div>
                            <div className="p-4 bg-black/20 rounded-2xl border border-white/5">
                                <div className="text-[11px] font-bold text-neutral-500 uppercase mb-2 leading-none">App Launch Ratio</div>
                                <div className="text-2xl font-black text-white font-mono tracking-tighter">99.8%</div>
                                <div className="text-[9px] text-emerald-400 font-bold uppercase mt-2">Verified Artifact</div>
                            </div>
                        </div>
                        <button className="w-full mt-8 bg-rose-600 hover:bg-rose-500 text-white text-xs font-black py-4 rounded-2xl transition-all shadow-xl shadow-rose-900/20">
                            Launch Manual Smoke Test Pool
                        </button>
                    </div>
                </div>
            </main>
        </div>
    );
};

export default Dashboard;
