<!DOCTYPE html>
<html lang="am">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ተስፋዬ ኃይሌ - የከባድ መኪና እና ማሽነሪዎች ኪራይ ቁጥጥር ዳሽቦርድ</title>
    <!-- Tailwind CSS ለዘመናዊና ውብ ገጽታ -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        brandGold: '#f59e0b',
                        brandDark: '#0f172a',
                        brandCard: '#1e293b',
                        brandGreen: '#10b981',
                        brandRed: '#ef4444',
                    },
                    fontFamily: {
                        ethiopic: ['Noto Sans Ethiopic', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Ethiopic:wght@300;400;600;700&family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Noto Sans Ethiopic', 'Poppins', sans-serif;
            background: radial-gradient(circle at top right, #1e293b, #0f172a);
        }
        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #0f172a;
        }
        ::-webkit-scrollbar-thumb {
            background: #f59e0b;
            border-radius: 4px;
        }
    </style>
</head>
<body class="text-slate-100 min-height-screen">

    <!-- TOP HEADER BAR -->
    <header class="border-b border-slate-800 bg-brandDark/80 backdrop-blur sticky top-0 z-50 px-4 py-3 lg:px-8">
        <div class="max-w-7xl mx-auto flex flex-col md:flex-row justify-between items-center gap-4">
            <div class="flex items-center gap-3">
                <div class="bg-brandGold text-brandDark p-3 rounded-xl font-bold text-2xl shadow-lg shadow-brandGold/20">
                    <i class="fa-solid fa-truck-monster animate-bounce"></i>
                </div>
                <div>
                    <h1 class="text-xl md:text-2xl font-bold tracking-tight text-white">ተስፋዬ ኃይሌ <span class="text-brandGold">የከባድ መኪናና ማሽነሪ ኪራይ</span></h1>
                    <p class="text-xs text-slate-400">የአስተዳደርና የደንበኞች መስተናገጃ አክቲቭ ዳሽቦርድ</p>
                </div>
            </div>
            
            <div class="flex items-center gap-4 w-full md:w-auto">
                <!-- Location & Interactive Button -->
                <div class="bg-slate-800/80 px-4 py-2 rounded-xl text-sm font-semibold text-slate-300 border border-slate-700/50 flex items-center gap-2">
                    <i class="fa-solid fa-location-dot text-brandGold text-base"></i>
                    <span>ድሬደዋ (Dire Dawa)</span>
                </div>
                
                <button onclick="openAddModal()" class="bg-brandGold hover:bg-amber-500 text-brandDark font-bold px-4 py-2.5 rounded-xl transition-all duration-300 flex items-center gap-2 shadow-lg shadow-brandGold/10 hover:shadow-brandGold/30">
                    <i class="fa-solid fa-circle-plus"></i>
                    <span>አዲስ ማሽን ጨምር</span>
                </button>
            </div>
        </div>
    </header>

    <!-- MAIN BODY -->
    <main class="max-w-7xl mx-auto px-4 py-8 lg:px-8">
        
        <!-- SEARCH & FILTER BAR -->
        <div class="bg-brandCard/50 border border-slate-800 rounded-2xl p-4 mb-8 flex flex-col md:flex-row justify-between items-center gap-4 backdrop-blur-sm">
            <div class="flex items-center gap-2 w-full md:w-96 bg-brandDark/80 border border-slate-700/50 px-4 py-2.5 rounded-xl">
                <i class="fa-solid fa-magnifying-glass text-slate-400"></i>
                <input type="text" id="searchInput" oninput="filterMachines()" placeholder="የማሽኑን ስም በመፈለግ ያጣሩ..." class="bg-transparent w-full focus:outline-none text-sm text-white placeholder-slate-500">
            </div>
            <div class="flex gap-2 w-full md:w-auto overflow-x-auto pb-1 md:pb-0">
                <button onclick="filterCategory('all')" id="btn-all" class="filter-btn bg-brandGold text-brandDark px-4 py-2 rounded-lg text-xs md:text-sm font-bold transition-all">ሁሉም</button>
                <button onclick="filterCategory('heavy')" id="btn-heavy" class="filter-btn bg-slate-800 text-slate-300 hover:text-white px-4 py-2 rounded-lg text-xs md:text-sm font-bold transition-all">ከባድ ማሽነሪዎች</button>
                <button onclick="filterCategory('truck')" id="btn-truck" class="filter-btn bg-slate-800 text-slate-300 hover:text-white px-4 py-2 rounded-lg text-xs md:text-sm font-bold transition-all">መኪናዎች (ሲኖ/አይሱዙ)</button>
            </div>
        </div>

        <!-- MACHINERY DASHBOARD GRID -->
        <div id="machineryGrid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <!-- Dynamic cards will render here via JS -->
        </div>
    </main>

    <!-- FOOTER -->
    <footer class="border-t border-slate-800/80 bg-brandDark/40 py-8 text-center text-sm text-slate-500 mt-20">
        <div class="max-w-7xl mx-auto px-4">
            <p class="font-semibold text-slate-400 mb-2">ተስፋዬ ኃይሌ የከባድ መኪናና ማሽነሪዎች ኪራይ አገልግሎት</p>
            <p class="text-xs">በድሬዳዋ እና በምስራቅ ኢትዮጵያ ቀዳሚው የታመነ የከባድ ማሽነሪዎች አቅራቢ</p>
            <p class="text-[10px] text-slate-600 mt-4">&copy; 2026 መብቱ በህግ የተጠበቀ ነው</p>
        </div>
    </footer>

    <!-- ADD/EDIT MACHINERY MODAL -->
    <div id="machineryModal" class="fixed inset-0 bg-brandDark/90 backdrop-blur-sm z-50 hidden flex items-center justify-center p-4">
        <div class="bg-brandCard border border-slate-700/60 rounded-3xl w-full max-w-lg overflow-hidden shadow-2xl relative animate-fade-in">
            <div class="border-b border-slate-800 p-6 flex justify-between items-center bg-brandDark/50">
                <h3 id="modalTitle" class="text-lg md:text-xl font-bold text-white">አዲስ ማሽነሪ መረጃ መመዝገቢያ</h3>
                <button onclick="closeModal()" class="text-slate-400 hover:text-white text-2xl transition-all"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <form id="machineryForm" onsubmit="saveMachine(event)" class="p-6 space-y-4">
                <input type="hidden" id="editIndex" value="-1">
                
                <div>
                    <label class="block text-xs font-semibold text-slate-400 uppercase tracking-wider mb-1">የማሽነሪው/መኪናው ዓይነት</label>
                    <input type="text" id="machineName" required placeholder="ምሳሌ፡ ካተርፒላር ሎደር (Loader)" class="w-full bg-brandDark/80 border border-slate-700 rounded-xl px-4 py-2.5 text-white focus:outline-none focus:border-brandGold transition-all">
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-semibold text-slate-400 uppercase tracking-wider mb-1">የኪራይ ዘርፍ</label>
                        <select id="machineCategory" class="w-full bg-brandDark/80 border border-slate-700 rounded-xl px-4 py-2.5 text-white focus:outline-none focus:border-brandGold transition-all">
                            <option value="heavy">ከባድ ማሽነሪ</option>
                            <option value="truck">መኪና (ሲኖ/አይሱዙ)</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-slate-400 uppercase tracking-wider mb-1">ሁኔታ (Status)</label>
                        <select id="machineStatus" class="w-full bg-brandDark/80 border border-slate-700 rounded-xl px-4 py-2.5 text-white focus:outline-none focus:border-brandGold transition-all">
                            <option value="available">ክፍት ነው (Available)</option>
                            <option value="rented">የተያዘ (Rented)</option>
                        </select>
                    </div>
                </div>

                <div>
                    <label class="block text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">የማሽነሪው ፎቶ (ከስልክዎ ይጫኑ ወይም የሊንክ አድራሻ ይጻፉ)</label>
                    <div class="flex flex-col gap-2">
                        <!-- File Upload Input -->
                        <div class="flex items-center justify-center w-full">
                            <label class="flex flex-col items-center justify-center w-full h-24 border-2 border-dashed border-slate-700 rounded-xl cursor-pointer hover:border-brandGold bg-brandDark/40 transition-all">
                                <div class="flex flex-col items-center justify-center pt-3 pb-4">
                                    <i class="fa-solid fa-cloud-arrow-up text-slate-400 text-lg mb-1"></i>
                                    <p class="text-xs text-slate-300 font-semibold">ከስልክዎ ፎቶ ለመጫን እዚህ ይንኩ</p>
                                    <p class="text-[10px] text-slate-500">PNG, JPG, JPEG</p>
                                </div>
                                <input type="file" id="imageFileInput" accept="image/*" onchange="previewImageFile(event)" class="hidden">
                            </label>
                        </div>
                        <div class="text-center text-xs text-slate-500 font-bold">ወይም</div>
                        <!-- URL Alternative -->
                        <input type="text" id="machineImageUrl" placeholder="የምስል ሊንክ (Image URL) ካለዎት እዚህ ያስገቡ" class="w-full bg-brandDark/80 border border-slate-700 rounded-xl px-4 py-2.5 text-white focus:outline-none focus:border-brandGold text-xs transition-all">
                    </div>
                    <div id="imagePreviewContainer" class="hidden mt-3 text-center">
                        <span class="text-xs text-brandGreen font-bold"><i class="fa-solid fa-circle-check"></i> ፎቶው በተሳካ ሁኔታ ተመርጧል!</span>
                    </div>
                </div>

                <div class="pt-4 flex gap-3">
                    <button type="button" onclick="closeModal()" class="w-1/2 bg-slate-800 hover:bg-slate-700 text-slate-300 font-bold py-3 rounded-xl transition-all">ሰርዝ</button>
                    <button type="submit" class="w-1/2 bg-brandGold hover:bg-amber-500 text-brandDark font-bold py-3 rounded-xl transition-all shadow-lg shadow-brandGold/10">መረጃውን መዝግብ</button>
                </div>
            </form>
        </div>
    </div>

    <!-- MAIN JAVASCRIPT FOR DYNAMIC DATA AND INTERACTIVITY -->
    <script>
        // Default Starting Data for Tesfaye Haile (Prices removed)
        const defaultMachineries = [
            {
                name: "ሎደር (Caterpillar Loader)",
                category: "heavy",
                status: "available",
                image: "https://images.unsplash.com/photo-1578328819058-b69f3a3b0f6b?auto=format&fit=crop&q=80&w=600",
                icon: "fa-snowplow"
            },
            {
                name: "እስካባተር (Excavator)",
                category: "heavy",
                status: "available",
                image: "https://images.unsplash.com/photo-1541625602330-2277a4c46182?auto=format&fit=crop&q=80&w=600",
                icon: "fa-truck-monster"
            },
            {
                name: "ትራክተር (Farm Tractor)",
                category: "heavy",
                status: "rented",
                image: "https://images.unsplash.com/photo-1594142167180-dd84e2df7dfd?auto=format&fit=crop&q=80&w=600",
                icon: "fa-tractor"
            },
            {
                name: "ሲኖ ትራክ (Sino Dump Truck)",
                category: "truck",
                status: "available",
                image: "https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?auto=format&fit=crop&q=80&w=600",
                icon: "fa-truck"
            },
            {
                name: "አይሱዙ (Isuzu FSR)",
                category: "truck",
                status: "available",
                image: "https://images.unsplash.com/photo-1516576111851-412717a41030?auto=format&fit=crop&q=80&w=600",
                icon: "fa-truck-pickup"
            }
        ];

        let machineries = [];
        let activeCategory = 'all';
        let currentUploadedImageBase64 = "";

        // Initialize App
        window.addEventListener('DOMContentLoaded', () => {
            const stored = localStorage.getItem('tesfaye_haile_machinery_noprice');
            if (stored) {
                machineries = JSON.parse(stored);
            } else {
                machineries = defaultMachineries;
                localStorage.setItem('tesfaye_haile_machinery_noprice', JSON.stringify(machineries));
            }
            renderMachinery();
        });

        // Save & Render function
        function saveAndRender() {
            localStorage.setItem('tesfaye_haile_machinery_noprice', JSON.stringify(machineries));
            renderMachinery();
        }

        // Render Cards
        function renderMachinery() {
            const grid = document.getElementById('machineryGrid');
            grid.innerHTML = '';

            const searchVal = document.getElementById('searchInput').value.toLowerCase();

            machineries.forEach((machine, index) => {
                // Filter Category
                if (activeCategory !== 'all' && machine.category !== activeCategory) return;
                
                // Filter Search
                if (searchVal && !machine.name.toLowerCase().includes(searchVal)) return;

                const statusBg = machine.status === 'available' ? 'bg-brandGreen' : 'bg-brandRed';
                const statusText = machine.status === 'available' ? 'ክፍት ነው (Available)' : 'የተያዘ (Rented)';
                const iconClass = machine.icon || (machine.category === 'heavy' ? 'fa-screwdriver-wrench' : 'fa-truck-moving');

                const cardHtml = `
                    <div class="bg-brandCard border border-slate-800 rounded-3xl overflow-hidden shadow-xl hover:shadow-2xl hover:border-brandGold/40 transition-all duration-300 relative group flex flex-col h-full">
                        
                        <!-- Machine Image Area -->
                        <div class="relative h-60 overflow-hidden bg-slate-950">
                            <img src="${machine.image}" alt="${machine.name}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                            
                            <!-- Overlay status tag -->
                            <span class="absolute top-4 right-4 ${statusBg} text-white text-xs font-bold px-3 py-1.5 rounded-full shadow-lg">
                                ${statusText}
                            </span>

                            <!-- Change Image Overlay Icon -->
                            <div class="absolute inset-0 bg-brandDark/50 opacity-0 group-hover:opacity-100 flex items-center justify-center transition-all duration-300 gap-2">
                                <label class="cursor-pointer bg-brandGold text-brandDark hover:bg-amber-500 font-bold p-3 rounded-full text-base shadow-lg transition-all" title="ፎቶ ቀይር / Upload New Image">
                                    <i class="fa-solid fa-camera"></i>
                                    <input type="file" accept="image/*" class="hidden" onchange="quickUploadImage(event, ${index})">
                                </label>
                                <button onclick="openEditModal(${index})" class="bg-slate-800 text-white hover:bg-slate-700 font-bold p-3 rounded-full text-base shadow-lg transition-all" title="መረጃ ማስተካከያ / Edit Name">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Card Content -->
                        <div class="p-6 flex flex-col flex-grow">
                            <!-- Name & Category Icon -->
                            <div class="flex items-start justify-between gap-2 mb-4">
                                <h3 class="text-lg font-bold text-white tracking-wide">${machine.name}</h3>
                                <div class="text-brandGold text-xl p-1 bg-brandDark/40 rounded-lg">
                                    <i class="fa-solid ${iconClass}"></i>
                                </div>
                            </div>

                            <!-- Pricing Info Replaced with Call-to-Action -->
                            <div class="bg-brandDark/60 border border-slate-800/80 rounded-xl p-4 mb-6 text-center">
                                <span class="text-brandGold font-medium text-xs md:text-sm tracking-wide block">
                                    <i class="fa-solid fa-tags mr-1"></i> ለዋጋ መረጃ ደውለው ይጠይቁ
                                </span>
                            </div>

                            <!-- Interactive Call / Rent button -->
                            <div class="mt-auto pt-2 flex gap-2">
                                <a href="tel:+251915000000" class="flex-grow bg-slate-800 hover:bg-slate-700 text-white font-bold py-3 px-4 rounded-xl text-center text-sm transition-all duration-300 flex items-center justify-center gap-2">
                                    <i class="fa-solid fa-phone text-brandGold"></i>
                                    <span>ደውለው ይዘዙ</span>
                                </a>
                                <button onclick="openEditModal(${index})" class="bg-slate-900 border border-slate-700 hover:bg-brandGold hover:text-brandDark text-slate-300 font-bold px-3 rounded-xl transition-all" title="መረጃ ለመቀየር">
                                    <i class="fa-solid fa-gears"></i>
                                </button>
                            </div>
                        </div>

                    </div>
                `;
                grid.innerHTML += cardHtml;
            });
        }

        // Quick upload image inside card hover trigger
        function quickUploadImage(event, index) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    machineries[index].image = e.target.result;
                    saveAndRender();
                };
                reader.readAsDataURL(file);
            }
        }

        // Handle Add Modal image choosing preview
        function previewImageFile(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    currentUploadedImageBase64 = e.target.result;
                    document.getElementById('imagePreviewContainer').classList.remove('hidden');
                };
                reader.readAsDataURL(file);
            }
        }

        // Add/Edit Modals handling
        function openAddModal() {
            document.getElementById('modalTitle').textContent = "አዲስ ከባድ ማሽነሪ/መኪና መመዝገቢያ";
            document.getElementById('editIndex').value = "-1";
            document.getElementById('machineryForm').reset();
            currentUploadedImageBase64 = "";
            document.getElementById('imagePreviewContainer').classList.add('hidden');
            document.getElementById('machineryModal').classList.remove('hidden');
        }

        function openEditModal(index) {
            const machine = machineries[index];
            document.getElementById('modalTitle').textContent = `${machine.name} - መረጃ ማስተካከያ`;
            document.getElementById('editIndex').value = index;
            document.getElementById('machineName').value = machine.name;
            document.getElementById('machineCategory').value = machine.category;
            document.getElementById('machineStatus').value = machine.status;
            document.getElementById('machineImageUrl').value = machine.image.startsWith("data:") ? "" : machine.image;
            
            currentUploadedImageBase64 = machine.image.startsWith("data:") ? machine.image : "";
            document.getElementById('imagePreviewContainer').classList.add('hidden');
            document.getElementById('machineryModal').classList.remove('hidden');
        }

        // Close Modal
        function closeModal() {
            document.getElementById('machineryModal').classList.add('hidden');
        }

        // Save Machine Function (Creates or Updates)
        function saveMachine(event) {
            event.preventDefault();
            
            const index = parseInt(document.getElementById('editIndex').value);
            const name = document.getElementById('machineName').value;
            const category = document.getElementById('machineCategory').value;
            const status = document.getElementById('machineStatus').value;
            const urlInput = document.getElementById('machineImageUrl').value;
            
            // Choose image source (either uploaded base64 file or text URL link)
            let image = "https://images.unsplash.com/photo-1541625602330-2277a4c46182?w=600"; // default fallback
            if (currentUploadedImageBase64) {
                image = currentUploadedImageBase64;
            } else if (urlInput) {
                image = urlInput;
            } else if (index !== -1) {
                image = machineries[index].image; // keep current
            }

            if (index === -1) {
                // Add New
                machineries.push({
                    name,
                    category,
                    status,
                    image,
                    icon: category === 'heavy' ? 'fa-screwdriver-wrench' : 'fa-truck-moving'
                });
            } else {
                // Update Existing
                machineries[index].name = name;
                machineries[index].category = category;
                machineries[index].status = status;
                machineries[index].image = image;
            }

            saveAndRender();
            closeModal();
        }

        // Category Filter Function
        function filterCategory(category) {
            activeCategory = category;
            
            // Highlight active button
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.classList.remove('bg-brandGold', 'text-brandDark');
                btn.classList.add('bg-slate-800', 'text-slate-300');
            });

            const activeBtn = document.getElementById(`btn-${category}`);
            if (activeBtn) {
                activeBtn.classList.remove('bg-slate-800', 'text-slate-300');
                activeBtn.classList.add('bg-brandGold', 'text-brandDark');
            }

            renderMachinery();
        }

        // Text Search Filter Function
        function filterMachines() {
            renderMachinery();
        }
    </script>
</body>
</html>
