import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const BharatWinnApp());
}

class BharatWinnApp extends StatelessWidget {
  const BharatWinnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: SafeArea(child: TeamReportWebView())),
    );
  }
}

class TeamReportWebView extends StatefulWidget {
  const TeamReportWebView({super.key});

  @override
  State<TeamReportWebView> createState() => _TeamReportWebViewState();
}

class _TeamReportWebViewState extends State<TeamReportWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            print("🌐 Page started loading: $url");
          },
          onPageFinished: (url) async {
            print("✅ Page finished loading: $url");
            if (url.contains("/promotion")) {
              print("📊 Injecting promotion script...");
              await _injectTeamReportScript();
            }
          },
          onWebResourceError: (error) {
            print("❌ WebView error: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse("https://bharatwinn.site/#/"));
  }

  /// Injects JavaScript into the TeamReport page
  Future<void> _injectTeamReportScript() async {
    const jsScript = r"""
      (function() {
        console.log("🚀 [Injector] TeamReport script injected successfully");
        console.log("🚀 [Injector] Current URL:", window.location.href);
        console.log("🚀 [Injector] Current page title:", document.title);
        console.log("🚀 [Injector] Document ready state:", document.readyState);
        console.log("🚀 [Injector] Script execution time:", new Date().toISOString());

        // -------------------------
        // 1. Data Mappings
        // -------------------------
        
        // Promotion page data mappings (using 2025-09-05 data)
        const promotionData = {
          // Direct subordinates (using 2025-09-05 values)
          'direct': {
            'number of register': '79',
            'Deposit number': '79',
            'Deposit amount': '56200',
            'Number of people making first deposit': '38'
          },
          // Team subordinates (using 2025-09-05 values)
          'team': {
            'number of register': '4',
            'Deposit number': '2',
            'Deposit amount': '450',
            'Number of people making first deposit': '2'
          },
          // Commission/Promotion data (using 2025-09-05 values)
          'commission': {
            'This Week': '562.00',
            'Total commission': '56200.00',
            'direct subordinate': '79',
            'Total number of subordinates in the team': '95'
          }
        };
        
        // Team Report date data mapping (2025-08-20 → 2025-09-05)
        const dateData = {
          "2025-09-05": {
            "Deposit number": "79",
            "Deposit amount": "56200",
            "Number of bettors": "95",
            "Total bet": "245000",
            "Number of people making first deposit": "38",
            "First deposit amount": "34200"
          },
          "2025-09-04": {
            "Deposit number": "71",
            "Deposit amount": "55500",
            "Number of bettors": "94",
            "Total bet": "242000",
            "Number of people making first deposit": "47",
            "First deposit amount": "33500"
          },
          "2025-09-03": {
            "Deposit number": "77",
            "Deposit amount": "55800",
            "Number of bettors": "93",
            "Total bet": "240000",
            "Number of people making first deposit": "36",
            "First deposit amount": "33100"
          },
          "2025-09-02": {
            "Deposit number": "69",
            "Deposit amount": "54800",
            "Number of bettors": "92",
            "Total bet": "238000",
            "Number of people making first deposit": "35",
            "First deposit amount": "32800"
          },
          "2025-09-01": {
            "Deposit number": "72",
            "Deposit amount": "52000",
            "Number of bettors": "88",
            "Total bet": "225000",
            "Number of people making first deposit": "32",
            "First deposit amount": "31000"
          },
          "2025-08-31": {
            "Deposit number": "64",
            "Deposit amount": "47890",
            "Number of bettors": "85",
            "Total bet": "210000",
            "Number of people making first deposit": "30",
            "First deposit amount": "28900"
          },
          "2025-08-30": {
            "Deposit number": "69",
            "Deposit amount": "45678",
            "Number of bettors": "82",
            "Total bet": "198765",
            "Number of people making first deposit": "28",
            "First deposit amount": "25678"
          },
          "2025-08-29": {
            "Deposit number": "61",
            "Deposit amount": "33026",
            "Number of bettors": "80",
            "Total bet": "150217",
            "Number of people making first deposit": "16",
            "First deposit amount": "13455"
          },
          "2025-08-28": {
            "Deposit number": "62",
            "Deposit amount": "34124",
            "Number of bettors": "75",
            "Total bet": "163823",
            "Number of people making first deposit": "19",
            "First deposit amount": "14524"
          },
          "2025-08-27": {
            "Deposit number": "70",
            "Deposit amount": "40585",
            "Number of bettors": "76",
            "Total bet": "245767",
            "Number of people making first deposit": "19",
            "First deposit amount": "21119"
          },
          "2025-08-26": {
            "Deposit number": "61",
            "Deposit amount": "44363",
            "Number of bettors": "74",
            "Total bet": "187832",
            "Number of people making first deposit": "26",
            "First deposit amount": "23885"
          },
          "2025-08-25": {
            "Deposit number": "70",
            "Deposit amount": "43468",
            "Number of bettors": "80",
            "Total bet": "191321",
            "Number of people making first deposit": "33",
            "First deposit amount": "18347"
          },
          "2025-08-24": {
            "Deposit number": "66",
            "Deposit amount": "30045",
            "Number of bettors": "81",
            "Total bet": "191924",
            "Number of people making first deposit": "29",
            "First deposit amount": "14402"
          },
          "2025-08-23": {
            "Deposit number": "63",
            "Deposit amount": "40824",
            "Number of bettors": "78",
            "Total bet": "256046",
            "Number of people making first deposit": "29",
            "First deposit amount": "20954"
          },
          "2025-08-22": {
            "Deposit number": "51",
            "Deposit amount": "23934",
            "Number of bettors": "62",
            "Total bet": "132607",
            "Number of people making first deposit": "15",
            "First deposit amount": "11774"
          },
          "2025-08-21": {
            "Deposit number": "51",
            "Deposit amount": "22181",
            "Number of bettors": "62",
            "Total bet": "124103",
            "Number of people making first deposit": "14",
            "First deposit amount": "9241"
          },
          "2025-08-20": {
            "Deposit number": "52",
            "Deposit amount": "26632",
            "Number of bettors": "72",
            "Total bet": "129343",
            "Number of people making first deposit": "13",
            "First deposit amount": "11636"
          }
        };

        // -------------------------
        // 2. Page Detection and Utility Functions
        // -------------------------
        
        // Page detection function
        function detectCurrentPage() {
          const url = window.location.href;
          const body = document.body;
          
          // Detect Team Report page
          if (url.includes('/#/promotion/TeamReport') || 
              url.includes('TeamReport') ||
              body.querySelector('.header-container')) {
            console.log('📍 Detected Team Report page');
            return 'TeamReport';
          }
          // Detect Promotion page (with new HTML structure)
          else if (url.includes('/#/promotion') || 
                   url.includes('promotion') ||
                   body.querySelector('.info_content') ||
                   body.querySelector('.info') && body.querySelector('.head')) {
            console.log('📍 Detected Promotion page');
            return 'Promotion';
          }
          // Detect other pages
          else {
            console.log('📍 Detected other page:', url);
            return 'Other';
          }
        }
        
        // Utility functions
        function safeQuerySelector(selector, parent = document) {
          try {
            return parent.querySelector(selector);
          } catch (e) {
            return null;
          }
        }
        
        function safeQuerySelectorAll(selector, parent = document) {
          try {
            return parent.querySelectorAll(selector);
          } catch (e) {
            return [];
          }
        }
        
        function safeTextContent(element) {
          try {
            return element && element.textContent ? element.textContent.trim() : '';
          } catch (e) {
            return '';
          }
        }
        
        // -------------------------
        // 3. Enhanced DOM Debugging
        // -------------------------
        function debugDOM() {
          console.log("🔍 [Debug] Starting DOM analysis...");
          
          // Check for various possible containers
          const containers = [
            '.header-container',
            '[class*="header"]',
            '[class*="container"]',
            '.TeamReport',
            '[class*="TeamReport"]'
          ];
          
          containers.forEach(selector => {
            const elements = document.querySelectorAll(selector);
            console.log(`📦 [Debug] Found ${elements.length} elements for selector: ${selector}`);
            elements.forEach((el, i) => {
              console.log(`  ${i}: ${el.className} - ${el.textContent.substring(0, 100)}...`);
            });
          });
          
          // Check for data items
          const dataSelectors = [
            'div[data-v-10d1559c]',
            '[class*="num"]',
            '.num',
            '[class*="data"]',
            'div[class*="item"]'
          ];
          
          dataSelectors.forEach(selector => {
            const elements = document.querySelectorAll(selector);
            console.log(`📊 [Debug] Found ${elements.length} data elements for selector: ${selector}`);
            elements.forEach((el, i) => {
              console.log(`  ${i}: ${el.className} - "${el.textContent.trim()}"`);
            });
          });
        }

        // -------------------------
        // 3. Enhanced Promotion Page Data Update Function
        // -------------------------
        function updatePromotionData() {
          console.log("🔄 [Promotion] Starting enhanced promotion data update...");
          
          let totalUpdated = 0;
          let attempts = 0;
          const maxAttempts = 3;
          
          // Multiple strategies to find and update promotion data
          const strategies = [
            // Strategy 1: .info_content container
            () => {
              console.log("🔍 [Promotion] Strategy 1: .info_content container");
          const infoContentDiv = safeQuerySelector('.info_content');
          if (infoContentDiv) {
            console.log('✅ [Promotion] Found .info_content container');
                return updatePromotionInContainer(infoContentDiv);
              }
              return 0;
            },
            
            // Strategy 2: Direct .info divs
            () => {
              console.log("🔍 [Promotion] Strategy 2: Direct .info divs");
              const infoDivs = safeQuerySelectorAll('.info');
              if (infoDivs.length > 0) {
                console.log(`🔄 [Promotion] Found ${infoDivs.length} .info divs directly`);
                return updatePromotionInDivs(infoDivs);
              }
              return 0;
            },
            
            // Strategy 3: Alternative selectors
            () => {
              console.log("🔍 [Promotion] Strategy 3: Alternative selectors");
              const alternativeSelectors = [
                '[class*="info"]',
                '[class*="promotion"]',
                '[class*="data"]',
                'div[class*="item"]',
                'div[class*="line"]'
              ];
              
              for (const selector of alternativeSelectors) {
                const elements = safeQuerySelectorAll(selector);
                if (elements.length > 0) {
                  console.log(`🔄 [Promotion] Found ${elements.length} elements with selector: ${selector}`);
                  const updated = updatePromotionInDivs(elements);
                  if (updated > 0) return updated;
                }
              }
              return 0;
            },
            
            // Strategy 4: Force update by finding numeric elements
            () => {
              console.log("🔍 [Promotion] Strategy 4: Force update numeric elements");
              return forceUpdatePromotionData();
            }
          ];
          
          // Try each strategy until we get results
          for (let i = 0; i < strategies.length; i++) {
            attempts++;
            console.log(`🔄 [Promotion] Attempt ${attempts}/${maxAttempts}: Strategy ${i + 1}`);
            
            const updated = strategies[i]();
            totalUpdated += updated;
            
            if (updated > 0) {
              console.log(`✅ [Promotion] Strategy ${i + 1} successful: ${updated} values updated`);
              break;
            } else {
              console.log(`⚠️ [Promotion] Strategy ${i + 1} failed, trying next...`);
            }
            
            if (attempts >= maxAttempts) break;
          }
          
          console.log(`🎯 [Promotion] Total values updated: ${totalUpdated}`);
          return totalUpdated > 0;
        }
        
        function updatePromotionInContainer(container) {
            let totalUpdated = 0;
          
          // Update specific amount element with data-v-6cf5705a - Enhanced targeting
          const amountSelectors = [
            'div[data-v-6cf5705a].amount',
            'div[data-v-6cf5705a][class*="amount"]',
            '.container div[data-v-6cf5705a].amount',
            'div[data-v-6cf5705a][data-v-600663f7] div[data-v-6cf5705a].amount',
            '.container .amount',
            'div[data-v-6cf5705a]',
            '.amount[data-v-6cf5705a]',
            '[data-v-6cf5705a].amount',
            'div.amount',
            '.amount'
          ];
          
          for (const selector of amountSelectors) {
            const amountElement = document.querySelector(selector);
            if (amountElement) {
              const currentValue = amountElement.textContent.trim();
              if (currentValue === '8607.36' || currentValue === '0' || parseFloat(currentValue) < 1000) {
                console.log(`✅ [Promotion] Updating amount element (${selector}) from "${currentValue}" to "809.32"`);
                amountElement.textContent = '809.32';
                totalUpdated++;
                break; // Stop after first successful update
              }
            }
          }
          
          // Get all .info divs within container
          const infoDivs = safeQuerySelectorAll('.info', container);
          console.log(`📊 [Promotion] Found ${infoDivs.length} .info divs in container`);
            
            infoDivs.forEach((infoDiv, infoIndex) => {
              try {
                console.log(`🔄 [Promotion] Processing .info div ${infoIndex + 1}...`);
                
                // Check if this is team section (has .head.u2 class)
                const headDiv = safeQuerySelector('.head', infoDiv);
                const isTeamSection = headDiv && headDiv.classList.contains('u2');
                const mapping = isTeamSection ? promotionData.team : promotionData.direct;
                
                console.log(`📋 [Promotion] Section type: ${isTeamSection ? 'Team subordinates' : 'Direct subordinates'}`);
                console.log(`📋 [Promotion] Using mapping:`, mapping);
                
              // Get all line divs (line1, line2, line3, line4, etc.)
              const lineDivs = safeQuerySelectorAll('.line1, .line2, .line3, .line4, .line5', infoDiv);
                console.log(`📊 [Promotion] Found ${lineDivs.length} line divs in this .info div`);
                
                lineDivs.forEach((lineDiv, lineIndex) => {
                  try {
                    // Find the number div (first div child)
                    const numberDiv = safeQuerySelector('div', lineDiv);
                    if (numberDiv) {
                      const currentValue = safeTextContent(numberDiv);
                      const lineText = safeTextContent(lineDiv);
                      
                      console.log(`📊 [Promotion] Line ${lineIndex + 1}: current value="${currentValue}", text="${lineText}"`);
                      
                    // Update if current value is '0' OR if it's a small number (likely real data)
                    if (currentValue === '0' || (parseInt(currentValue) < 10 && parseInt(currentValue) >= 0)) {
                        // Find matching key in mapping
                        let matched = false;
                        Object.entries(mapping).forEach(([key, value]) => {
                          if (lineText.includes(key)) {
                            console.log(`✅ [Promotion] Updating "${key}" from "${currentValue}" to "${value}"`);
                            numberDiv.textContent = value;
                            matched = true;
                            totalUpdated++;
                          }
                        });
                        
                        if (!matched) {
                          console.log(`⚠️ [Promotion] No mapping found for line: "${lineText}"`);
                        }
                      } else {
                      console.log(`⏭️ [Promotion] Skipping line with value: "${currentValue}"`);
                      }
                    } else {
                      console.log(`❌ [Promotion] No number div found in line ${lineIndex + 1}`);
                    }
                  } catch (e) {
                    console.log(`❌ [Promotion] Error processing line ${lineIndex + 1}:`, e);
                  }
                });
              } catch (e) {
                console.log(`❌ [Promotion] Error processing .info div ${infoIndex + 1}:`, e);
              }
            });
            
          return totalUpdated;
        }
        
        function updatePromotionInDivs(divs) {
              let totalUpdated = 0;
          
          // Update specific amount element with data-v-6cf5705a - Enhanced targeting
          const amountSelectors = [
            'div[data-v-6cf5705a].amount',
            'div[data-v-6cf5705a][class*="amount"]',
            '.container div[data-v-6cf5705a].amount',
            'div[data-v-6cf5705a][data-v-600663f7] div[data-v-6cf5705a].amount',
            '.container .amount',
            'div[data-v-6cf5705a]',
            '.amount[data-v-6cf5705a]',
            '[data-v-6cf5705a].amount',
            'div.amount',
            '.amount'
          ];
          
          for (const selector of amountSelectors) {
            const amountElement = document.querySelector(selector);
            if (amountElement) {
              const currentValue = amountElement.textContent.trim();
              if (currentValue === '8607.36' || currentValue === '0' || parseFloat(currentValue) < 1000) {
                console.log(`✅ [Promotion] Updating amount element (${selector}) from "${currentValue}" to "809.32"`);
                amountElement.textContent = '809.32';
                totalUpdated++;
                break; // Stop after first successful update
              }
            }
          }
          
          divs.forEach((infoDiv, infoIndex) => {
                try {
                  const isTeamSection = safeQuerySelector('.head.u2', infoDiv) !== null;
                  const mapping = isTeamSection ? promotionData.team : promotionData.direct;
                  
              const lineDivs = safeQuerySelectorAll('.line1, .line2, .line3, .line4, .line5', infoDiv);
                  lineDivs.forEach(lineDiv => {
                    try {
                      const numberDiv = safeQuerySelector('div', lineDiv);
                  if (numberDiv) {
                    const currentValue = safeTextContent(numberDiv);
                        const textContent = safeTextContent(lineDiv);
                        
                    // Update if current value is '0' OR if it's a small number
                    if (currentValue === '0' || (parseInt(currentValue) < 10 && parseInt(currentValue) >= 0)) {
                        Object.entries(mapping).forEach(([key, value]) => {
                          if (textContent.includes(key)) {
                          console.log(`✅ [Promotion] Direct update: "${key}" from "${currentValue}" to "${value}"`);
                            numberDiv.textContent = value;
                            totalUpdated++;
                          }
                        });
                    }
                      }
                    } catch (e) {
                      // Individual line error - continue with others
                    }
                  });
                } catch (e) {
                  // Individual info div error - continue with others
                }
              });
              
          return totalUpdated;
        }
        
        function forceUpdatePromotionData() {
          console.log("🔍 [Promotion] Force updating promotion data...");
          let totalUpdated = 0;
          
          // AGGRESSIVE AMOUNT ELEMENT UPDATE - Multiple strategies
          console.log("🔍 [Promotion] AGGRESSIVE: Looking for amount element with data-v-6cf5705a...");
          
          // Strategy 1: Try multiple selectors
          const amountSelectors = [
            'div[data-v-6cf5705a].amount',
            'div[data-v-6cf5705a][class*="amount"]',
            '.container div[data-v-6cf5705a].amount',
            'div[data-v-6cf5705a][data-v-600663f7] div[data-v-6cf5705a].amount',
            '.container .amount',
            'div[data-v-6cf5705a]',
            '.amount[data-v-6cf5705a]',
            '[data-v-6cf5705a].amount',
            'div.amount',
            '.amount'
          ];
          
          let amountElement = null;
          let usedSelector = '';
          
          for (const selector of amountSelectors) {
            const element = document.querySelector(selector);
            if (element) {
              const text = element.textContent.trim();
              console.log(`🔍 [Promotion] Found element with selector "${selector}": text="${text}"`);
              
              // Check if this looks like our target element
              if (text === '8607.36' || text === '0' || (parseFloat(text) < 1000 && parseFloat(text) >= 0)) {
                amountElement = element;
                usedSelector = selector;
                console.log(`✅ [Promotion] Confirmed target element with selector: ${selector}`);
                break;
              }
            }
          }
          
          // Strategy 2: If not found, try brute force search
          if (!amountElement) {
            console.log("🔍 [Promotion] AGGRESSIVE: Trying brute force search...");
            const allElements = document.querySelectorAll('*');
            
            for (let i = 0; i < allElements.length; i++) {
              const element = allElements[i];
              const text = element.textContent.trim();
              
              // Check if element has the right attributes and text
              if (element.hasAttribute('data-v-6cf5705a') && 
                  element.classList.contains('amount') && 
                  (text === '8607.36' || text === '0')) {
                amountElement = element;
                usedSelector = 'brute-force-search';
                console.log(`✅ [Promotion] Found target element via brute force: ${element.outerHTML}`);
                break;
              }
            }
          }
          
          // Strategy 3: Try to find by parent context
          if (!amountElement) {
            console.log("🔍 [Promotion] AGGRESSIVE: Trying parent context search...");
            const containers = document.querySelectorAll('.container');
            
            for (const container of containers) {
              const amountDivs = container.querySelectorAll('div[data-v-6cf5705a]');
              for (const div of amountDivs) {
                if (div.classList.contains('amount') && (div.textContent.trim() === '8607.36' || div.textContent.trim() === '0')) {
                  amountElement = div;
                  usedSelector = 'parent-context-search';
                  console.log(`✅ [Promotion] Found target element via parent context: ${div.outerHTML}`);
                  break;
                }
              }
              if (amountElement) break;
            }
          }
          
          // Update the element if found
          if (amountElement) {
            const currentValue = amountElement.textContent.trim();
            console.log(`🔄 [Promotion] AGGRESSIVE: Updating amount element (${usedSelector}) from "${currentValue}" to "809.32"`);
            
            // Try multiple update methods
            try {
              amountElement.textContent = '809.32';
              console.log(`✅ [Promotion] Method 1 (textContent): Success`);
            } catch (e) {
              console.log(`⚠️ [Promotion] Method 1 failed: ${e}`);
            }
            
            try {
              amountElement.innerHTML = '809.32';
              console.log(`✅ [Promotion] Method 2 (innerHTML): Success`);
            } catch (e) {
              console.log(`⚠️ [Promotion] Method 2 failed: ${e}`);
            }
            
            try {
              amountElement.innerText = '809.32';
              console.log(`✅ [Promotion] Method 3 (innerText): Success`);
            } catch (e) {
              console.log(`⚠️ [Promotion] Method 3 failed: ${e}`);
            }
            
            totalUpdated++;
            console.log(`✅ [Promotion] AGGRESSIVE: Successfully updated amount element to "809.32"`);
            
            // Verify the update
            setTimeout(() => {
              const newValue = amountElement.textContent.trim();
              console.log(`🔍 [Promotion] Verification: Element now contains "${newValue}"`);
            }, 100);
            
          } else {
            console.log("❌ [Promotion] AGGRESSIVE: Amount element with data-v-6cf5705a not found with any method");
            
            // Enhanced Debug: Show all elements with data-v-6cf5705a
            const allElements = document.querySelectorAll('[data-v-6cf5705a]');
            console.log(`🔍 [Debug] Found ${allElements.length} elements with data-v-6cf5705a:`);
            allElements.forEach((el, i) => {
              console.log(`  ${i}: ${el.tagName} - classes: "${el.className}" - text: "${el.textContent.trim()}" - HTML: ${el.outerHTML.substring(0, 100)}...`);
            });
            
            // Enhanced Debug: Show all elements with class "amount"
            const amountElements = document.querySelectorAll('.amount');
            console.log(`🔍 [Debug] Found ${amountElements.length} elements with class "amount":`);
            amountElements.forEach((el, i) => {
              console.log(`  ${i}: ${el.tagName} - data-v: "${el.getAttribute('data-v-6cf5705a')}" - text: "${el.textContent.trim()}" - HTML: ${el.outerHTML.substring(0, 100)}...`);
            });
          }
          
          // Find all elements that might contain promotion data
          const allElements = document.querySelectorAll('*');
          const numericElements = [];
          
          allElements.forEach(element => {
            const text = element.textContent.trim();
            // Look for elements with small numbers (likely real data to replace)
            if (/^\d+$/.test(text) && parseInt(text) < 100 && parseInt(text) >= 0) {
              numericElements.push(element);
            }
          });
          
          console.log(`🔍 [Promotion] Found ${numericElements.length} numeric elements to check`);
          
          // Try to match and update based on context
          numericElements.forEach(element => {
            const parent = element.parentElement;
            if (parent) {
              const parentText = parent.textContent.toLowerCase();
              const currentValue = element.textContent.trim();
              
              // Check for direct subordinates
              if (parentText.includes('direct') || parentText.includes('register') || parentText.includes('deposit')) {
                Object.entries(promotionData.direct).forEach(([key, value]) => {
                  if (parentText.includes(key.toLowerCase())) {
                    console.log(`✅ [Promotion] Force update direct: "${key}" from "${currentValue}" to "${value}"`);
                    element.textContent = value;
                    totalUpdated++;
                  }
                });
              }
              
              // Check for team subordinates
              if (parentText.includes('team') || parentText.includes('subordinate')) {
                Object.entries(promotionData.team).forEach(([key, value]) => {
                  if (parentText.includes(key.toLowerCase())) {
                    console.log(`✅ [Promotion] Force update team: "${key}" from "${currentValue}" to "${value}"`);
                    element.textContent = value;
                    totalUpdated++;
                  }
                });
              }
            }
          });
          
          return totalUpdated;
        }
        
        // -------------------------
        // 3.1. Enhanced Commission Data Update Function
        // -------------------------
        function updateCommissionData() {
          console.log("🔄 [Commission] Starting enhanced commission data update...");
          
          let totalUpdated = 0;
          
          // Update the main commission amount (Yesterday's total commission)
          const commissionAmountSelectors = [
            'div[data-v-6cf5705a].amount',
            '.container div[data-v-6cf5705a].amount',
            'div[data-v-6cf5705a][data-v-600663f7] div[data-v-6cf5705a].amount',
            '.container .amount',
            '.amount'
          ];
          
          for (const selector of commissionAmountSelectors) {
            const amountElement = document.querySelector(selector);
            if (amountElement) {
              const currentValue = amountElement.textContent.trim();
              if (currentValue === '8607.36' || currentValue === '0' || parseFloat(currentValue) < 1000) {
                console.log(`✅ [Commission] Updating commission amount (${selector}) from "${currentValue}" to "809.32"`);
                amountElement.textContent = '809.32';
                totalUpdated++;
                break;
              }
            }
          }
          
          // Look for .commission container (legacy support)
          const commissionDiv = safeQuerySelector('.commission');
          if (commissionDiv) {
            console.log('✅ [Commission] Found .commission container');
            
            // Get all .commission__body divs
            const commissionBodyDivs = safeQuerySelectorAll('.commission__body', commissionDiv);
            console.log(`📊 [Commission] Found ${commissionBodyDivs.length} .commission__body divs`);
            
            commissionBodyDivs.forEach((bodyDiv, bodyIndex) => {
              try {
                console.log(`🔄 [Commission] Processing .commission__body div ${bodyIndex + 1}...`);
                
                // Get all direct child divs within this body div (each div contains value-label pair)
                const valueLabelDivs = safeQuerySelectorAll('div', bodyDiv);
                console.log(`📊 [Commission] Found ${valueLabelDivs.length} value-label divs in body div ${bodyIndex + 1}`);
                
                valueLabelDivs.forEach((valueLabelDiv, divIndex) => {
                  try {
                    console.log(`🔄 [Commission] Processing value-label div ${divIndex + 1}...`);
                    
                    // Get spans within this div
                    const spans = safeQuerySelectorAll('span', valueLabelDiv);
                    console.log(`📊 [Commission] Found ${spans.length} spans in value-label div ${divIndex + 1}`);
                    
                    if (spans.length >= 2) {
                      const valueSpan = spans[0]; // First span is the value
                      const labelSpan = spans[1]; // Second span is the label
                      
                      const valueText = safeTextContent(valueSpan);
                      const labelText = safeTextContent(labelSpan);
                      
                      console.log(`📊 [Commission] Value: "${valueText}", Label: "${labelText}"`);
                      
                      // Check if this span contains "0" (the value to update)
                      if (valueText === '0') {
                        console.log(`📋 [Commission] Found value "0" with label: "${labelText}"`);
                        
                        // Apply commission data values
                        Object.entries(promotionData.commission).forEach(([key, value]) => {
                          if (labelText.includes(key)) {
                            console.log(`✅ [Commission] Updating "${key}" from "0" to "${value}"`);
                            valueSpan.textContent = value;
                            totalUpdated++;
                          }
                        });
                      } else {
                        console.log(`⏭️ [Commission] Skipping non-zero value: "${valueText}"`);
                      }
                    } else {
                      console.log(`⚠️ [Commission] Not enough spans in value-label div ${divIndex + 1}`);
                    }
                  } catch (e) {
                    console.log(`❌ [Commission] Error processing value-label div ${divIndex + 1}:`, e);
                  }
                });
              } catch (e) {
                console.log(`❌ [Commission] Error processing body div ${bodyIndex + 1}:`, e);
              }
            });
          } else {
            console.log('ℹ️ [Commission] No .commission container found, using direct amount update');
          }
            
            console.log(`🎯 [Commission] Total values updated: ${totalUpdated}`);
            return totalUpdated > 0;
        }
        
        // -------------------------
        // 4. Complete DOM Analysis and Value Update Function
        // -------------------------
        function updateTeamReport(dateText) {
          console.log("🔍 [updateTeamReport] ===== STARTING UPDATE =====");
          console.log("🔍 [updateTeamReport] Date:", dateText);
          console.log("🔍 [updateTeamReport] Available dates:", Object.keys(dateData));

          const values = dateData[dateText];
          if (!values) {
            console.warn("⚠️ [updateTeamReport] No values mapped for this date:", dateText);
            return;
          }

          console.log("✅ [updateTeamReport] Values to update:", values);

          let updatedCount = 0;
          
          // Expected order based on the HTML structure: Deposit number, Deposit amount, Number of bettors, Total bet, Number of people making first deposit, First deposit amount
          const expectedOrder = [
            "Deposit number",
            "Deposit amount", 
            "Number of bettors",
            "Total bet",
            "Number of people making first deposit",
            "First deposit amount"
          ];

          // Method 1: Direct .num elements update - ONLY update pure numeric values
          console.log("🔍 [updateTeamReport] === METHOD 1: Direct .num elements ===");
          const numElements = document.querySelectorAll('.num');
          console.log(`🔍 [updateTeamReport] Found ${numElements.length} .num elements:`, Array.from(numElements).map(el => el.textContent.trim()));
          
          numElements.forEach((element, index) => {
            if (index < expectedOrder.length) {
              const label = expectedOrder[index];
              const newValue = values[label];
              if (newValue) {
                const oldValue = element.textContent.trim();
                
                // CRITICAL: Only update if it's a pure number (no text labels)
                if (element.classList.contains('num') && /^\d+$/.test(oldValue)) {
                  console.log(`🔄 [updateTeamReport] Updating .num[${index}] (${label}) from "${oldValue}" to "${newValue}"`);
                  element.textContent = newValue;
                  updatedCount++;
                } else {
                  console.log(`⚠️ [updateTeamReport] Skipping .num[${index}] - contains text/labels: "${oldValue}"`);
                }
              }
            }
          });

          // Method 2: Header-container specific approach - ONLY update pure numeric values
          if (updatedCount === 0) {
            console.log("🔍 [updateTeamReport] === METHOD 2: Header-container approach ===");
            
            const headerContainer = document.querySelector('.header-container');
            if (headerContainer) {
              console.log("🔍 [updateTeamReport] Found header-container, looking for .num elements within...");
              
              const containerNumElements = headerContainer.querySelectorAll('.num');
              console.log(`🔍 [updateTeamReport] Found ${containerNumElements.length} .num elements in header-container`);
              
              containerNumElements.forEach((element, index) => {
                if (index < expectedOrder.length) {
                  const label = expectedOrder[index];
                  const newValue = values[label];
                  if (newValue) {
                    const oldValue = element.textContent.trim();
                    
                    // CRITICAL: Only update if it's a pure number (no text labels)
                    if (/^\d+$/.test(oldValue)) {
                      console.log(`🔄 [updateTeamReport] Updating header-container .num[${index}] (${label}) from "${oldValue}" to "${newValue}"`);
                      element.textContent = newValue;
                      updatedCount++;
                    } else {
                      console.log(`⚠️ [updateTeamReport] Skipping header-container .num[${index}] - contains text/labels: "${oldValue}"`);
                    }
                  }
                }
              });
            } else {
              console.log("❌ [updateTeamReport] No header-container found");
            }
          }

          // Method 3: If still no updates, try alternative selectors for pure numeric elements
          if (updatedCount === 0) {
            console.log("🔍 [updateTeamReport] === METHOD 3: Alternative numeric selectors ===");
            
            // Try to find elements that contain only numbers (no text labels)
            const numericSelectors = [
              '.num',
              '[class*="num"]',
              'div[class*="value"]',
              'span[class*="value"]',
              'div[class*="data"]',
              'span[class*="data"]'
            ];
            
            for (const selector of numericSelectors) {
              const elements = document.querySelectorAll(selector);
              console.log(`🔍 [updateTeamReport] Checking selector "${selector}": found ${elements.length} elements`);
              
              elements.forEach((element, index) => {
                const text = element.textContent.trim();
                
                // CRITICAL: Only update if it's a pure number (no text labels)
                if (/^\d+$/.test(text) && index < expectedOrder.length) {
                  const label = expectedOrder[index];
                  const newValue = values[label];
                  if (newValue) {
                    console.log(`🔄 [updateTeamReport] Updating ${selector}[${index}] (${label}) from "${text}" to "${newValue}"`);
                    element.textContent = newValue;
                    updatedCount++;
                  }
                } else {
                  console.log(`⚠️ [updateTeamReport] Skipping ${selector}[${index}] - contains text/labels: "${text}"`);
                }
              });
              
              if (updatedCount > 0) break; // Stop if we found and updated elements
            }
          }

          // Method 4: Final fallback - search for any element with pure numeric content
          if (updatedCount === 0) {
            console.log("🔍 [updateTeamReport] === METHOD 4: Pure numeric content search ===");
            
            // Find all elements that contain only numbers
            const allElements = document.querySelectorAll('*');
            const numericElements = [];
            
            allElements.forEach(element => {
              const text = element.textContent.trim();
              // Only consider elements with pure numeric content (no text labels)
              if (/^\d+$/.test(text) && text.length > 0 && text.length < 10) {
                numericElements.push(element);
              }
            });
            
            console.log(`🔍 [updateTeamReport] Found ${numericElements.length} elements with pure numeric content`);
            
            // Update the first 6 numeric elements we find (assuming they're our data)
            numericElements.slice(0, 6).forEach((element, index) => {
              if (index < expectedOrder.length) {
                const label = expectedOrder[index];
                const newValue = values[label];
                if (newValue) {
                  const oldValue = element.textContent.trim();
                  console.log(`🔄 [updateTeamReport] Updating numeric element[${index}] (${label}) from "${oldValue}" to "${newValue}"`);
                  element.textContent = newValue;
                  updatedCount++;
                }
              }
            });
          }

          console.log(`🎯 [updateTeamReport] ===== FINAL RESULT: ${updatedCount} values updated =====`);
          
          if (updatedCount === 0) {
            console.log("❌ [updateTeamReport] No values were updated. Running debug...");
            debugDOM();
          } else {
            console.log(`✅ [updateTeamReport] Successfully updated ${updatedCount} values!`);
          }
        }

        // -------------------------
        // 4. Enhanced Date Watcher
        // -------------------------
        function startDateWatcher() {
          console.log("👀 [Watcher] Starting date watcher...");
          
          // Try multiple selectors for the date span - updated with correct structure
          const dateSelectors = [
            '.TeamReport__C-head-line2 div[data-v-10d1559c]:nth-child(2) span.default[data-v-10d1559c]',  // Second div (date) not first (All)
            '.TeamReport__C-head-line2 span.default[data-v-10d1559c]:nth-child(2)',                      // Second span in the container
            'div[data-v-10d1559c] span.default[data-v-10d1559c]',  // Any span with the structure
            'span.default[data-v-10d1559c]',                      // Span with both classes and data attribute
            'span.default',                                        // Original selector
            '.TeamReport__C-head-line2 span.default',
            '[class*="date"]',
            '[class*="Date"]',
            'span[class*="head"]',
            'span'
          ];

          let dateSpan = null;
          for (const selector of dateSelectors) {
            const foundSpan = document.querySelector(selector);
            if (foundSpan && foundSpan.textContent.trim()) {
              const text = foundSpan.textContent.trim();
              // Make sure it's not "All" and looks like a date
              if (text !== "All" && text.match(/\d{4}-\d{2}-\d{2}/)) {
                dateSpan = foundSpan;
                console.log(`✅ [Watcher] Found date span with selector: ${selector}`);
                console.log(`📅 [Watcher] Date span content: "${text}"`);
                console.log(`📅 [Watcher] Date span classes: "${dateSpan.className}"`);
                console.log(`📅 [Watcher] Date span attributes:`, dateSpan.attributes);
                break;
              } else {
                console.log(`⚠️ [Watcher] Found span but not a date: "${text}"`);
              }
            }
          }

          if (!dateSpan) {
            console.warn("⚠️ [Watcher] Date span not found. Retrying in 2s...");
            // Debug: show all spans with data-v-10d1559c
            const allSpans = document.querySelectorAll('span[data-v-10d1559c]');
            console.log(`🔍 [Debug] Found ${allSpans.length} spans with data-v-10d1559c:`);
            allSpans.forEach((span, i) => {
              console.log(`  ${i}: "${span.textContent.trim()}" - classes: "${span.className}"`);
            });
            setTimeout(startDateWatcher, 2000);
            return;
          }

          const currentDate = dateSpan.textContent.trim();
          console.log("👀 [Watcher] Watching date span:", currentDate);

          // Run once immediately
          updateTeamReport(currentDate);

          // Setup observer
          const observer = new MutationObserver(mutations => {
            mutations.forEach(m => {
              if (m.type === "characterData" || m.type === "childList") {
                const newDate = dateSpan.textContent.trim();
                if (newDate !== currentDate) {
                  console.log("📅 [Watcher] Date changed to:", newDate);
                  updateTeamReport(newDate);
                }
              }
            });
          });

          observer.observe(dateSpan, {
            characterData: true,
            childList: true,
            subtree: true
          });

          // Also observe the parent container for changes
          if (dateSpan.parentElement) {
            observer.observe(dateSpan.parentElement, {
              childList: true,
              subtree: true
            });
          }
        }

        // -------------------------
        // 5. Continuous Data Monitoring and Persistence
        // -------------------------
        let dataUpdateInterval = null;
        let lastUpdateTime = 0;
        let amountObserver = null;
        
        // Enhanced Mutation Observer for persistent override
        function setupAmountObserver() {
          console.log("👀 [Observer] Setting up PERSISTENT mutation observer for amount element...");
          
          if (amountObserver) {
            amountObserver.disconnect();
          }
          
          amountObserver = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
              if (mutation.type === 'childList' || mutation.type === 'characterData') {
                // Check if any amount elements were added or changed
                const target = mutation.target;
                
                // Check for amount element specifically
                if (target.classList && target.classList.contains('amount') && 
                    target.hasAttribute('data-v-6cf5705a') && 
                    (target.textContent.trim() === '8607.36' || target.textContent.trim() === '0')) {
                  console.log("🚨 [Observer] DETECTED RESET! Amount element changed back to original value, overriding...");
                  target.textContent = '809.32';
                  console.log("✅ [Observer] PERSISTENT OVERRIDE: Set amount to 809.32");
                }
                
                // Also check for any div with data-v-6cf5705a that contains '8607.36' or '0'
                if (target.hasAttribute && target.hasAttribute('data-v-6cf5705a') && 
                    target.textContent && (target.textContent.trim() === '8607.36' || target.textContent.trim() === '0')) {
                  console.log("🚨 [Observer] DETECTED RESET! Element with data-v-6cf5705a reset to original value, checking if it's amount...");
                  
                  // Check if this is the amount element
                  if (target.classList && target.classList.contains('amount')) {
                    target.textContent = '809.32';
                    console.log("✅ [Observer] PERSISTENT OVERRIDE: Set amount element to 809.32");
                  }
                }
              }
            });
          });
          
          // Observe the entire document for changes with more aggressive settings
          amountObserver.observe(document.body, {
            childList: true,
            subtree: true,
            characterData: true,
            attributes: true,
            attributeOldValue: true
          });
          
          console.log("✅ [Observer] PERSISTENT mutation observer setup complete");
        }
        
        function startContinuousMonitoring() {
          console.log("🔄 [Monitor] Starting continuous data monitoring...");
          
          // Clear any existing interval
          if (dataUpdateInterval) {
            clearInterval(dataUpdateInterval);
          }
          
          // Check and update data every 500ms for more aggressive monitoring
          dataUpdateInterval = setInterval(() => {
            const currentPage = detectCurrentPage();
            const currentTime = Date.now();
            
            // Only update if enough time has passed (prevent spam) - reduced to 500ms
            if (currentTime - lastUpdateTime < 500) {
              return;
            }
            
            if (currentPage === 'TeamReport') {
              console.log("🔄 [Monitor] Checking Team Report data...");
              
              // Find current date and update data
              const dateSelectors = [
                '.TeamReport__C-head-line2 div[data-v-10d1559c]:nth-child(2) span.default[data-v-10d1559c]',
                '.TeamReport__C-head-line2 span.default[data-v-10d1559c]:nth-child(2)',
                'div[data-v-10d1559c] span.default[data-v-10d1559c]',
                'span.default[data-v-10d1559c]',
                'span.default'
              ];
              
              for (const selector of dateSelectors) {
                const dateSpan = document.querySelector(selector);
                if (dateSpan && dateSpan.textContent.trim()) {
                  const text = dateSpan.textContent.trim();
                  if (text !== "All" && text.match(/\d{4}-\d{2}-\d{2}/)) {
                    console.log("🔄 [Monitor] Updating Team Report data for date:", text);
                    updateTeamReport(text);
                    lastUpdateTime = currentTime;
                    break;
                  }
                }
              }
            } else if (currentPage === 'Promotion') {
              console.log("🔄 [Monitor] Checking Promotion data...");
              
              // Enhanced check for promotion data that needs updating
              let needsUpdate = false;
              
              // Check for '0' values in various selectors
              const checkSelectors = [
                '.info_content .num',
                '.info .num',
                '[class*="num"]',
                'div[class*="line"] div'
              ];
              
              for (const selector of checkSelectors) {
                const elements = document.querySelectorAll(selector);
                if (elements.length > 0) {
                  const hasZeroValues = Array.from(elements).some(el => {
                    const text = el.textContent.trim();
                    return text === '0' || (parseInt(text) < 10 && parseInt(text) >= 0);
                  });
                  
                  if (hasZeroValues) {
                    needsUpdate = true;
                    console.log(`🔄 [Monitor] Found values needing update with selector: ${selector}`);
                    break;
                  }
                }
              }
              
              // Also check for commission data
              const commissionElements = document.querySelectorAll('.commission span');
              const hasCommissionZeros = Array.from(commissionElements).some(el => el.textContent.trim() === '0');
              
              if (hasCommissionZeros) {
                needsUpdate = true;
                console.log("🔄 [Monitor] Found commission values needing update");
              }
              
              // Check for specific amount element with multiple selectors
              const amountSelectors = [
                'div[data-v-6cf5705a].amount',
                'div[data-v-6cf5705a][class*="amount"]',
                '.container div[data-v-6cf5705a].amount',
                'div[data-v-6cf5705a][data-v-600663f7] div[data-v-6cf5705a].amount',
                '.container .amount',
                'div[data-v-6cf5705a]',
                '.amount[data-v-6cf5705a]',
                '[data-v-6cf5705a].amount',
                'div.amount',
                '.amount'
              ];
              
              for (const selector of amountSelectors) {
                const amountElement = document.querySelector(selector);
                if (amountElement && (amountElement.textContent.trim() === '8607.36' || amountElement.textContent.trim() === '0' || parseFloat(amountElement.textContent.trim()) < 1000)) {
                  needsUpdate = true;
                  console.log(`🔄 [Monitor] Found amount element needing update with selector: ${selector}`);
                  break;
                }
              }
              
              if (needsUpdate) {
                console.log("🔄 [Monitor] Promotion data needs updating...");
                updatePromotionData();
                updateCommissionData();
                lastUpdateTime = currentTime;
              } else {
                console.log("✅ [Monitor] Promotion data looks good, no update needed");
              }
            }
          }, 500);
        }
        
        function stopContinuousMonitoring() {
          if (dataUpdateInterval) {
            clearInterval(dataUpdateInterval);
            dataUpdateInterval = null;
            console.log("⏹️ [Monitor] Stopped continuous monitoring");
          }
        }
        
        // Delayed amount element update after page load
        function updateAmountElementDelayed() {
          console.log("⏰ [Delayed] Executing delayed amount element update...");
          
          const amountSelectors = [
            'div[data-v-6cf5705a].amount',
            '.container div[data-v-6cf5705a].amount',
            'div[data-v-6cf5705a][data-v-600663f7] div[data-v-6cf5705a].amount',
            '.container .amount',
            '.amount'
          ];
          
          let found = false;
          for (const selector of amountSelectors) {
            const element = document.querySelector(selector);
            if (element) {
              const currentValue = element.textContent.trim();
              console.log(`⏰ [Delayed] Found element with selector "${selector}": current value="${currentValue}"`);
              
              if (currentValue === '8607.36' || currentValue === '0' || parseFloat(currentValue) < 1000) {
                console.log(`⏰ [Delayed] Updating amount element from "${currentValue}" to "809.32"`);
                element.textContent = '809.32';
                found = true;
                console.log(`✅ [Delayed] Successfully updated amount element to 809.32`);
                break;
              } else {
                console.log(`⏰ [Delayed] Element already has value "${currentValue}", skipping`);
              }
            }
          }
          
          if (!found) {
            console.log("⚠️ [Delayed] No amount element found to update");
            
            // Debug: Show what elements we found
            const allAmountElements = document.querySelectorAll('.amount');
            console.log(`🔍 [Delayed] Found ${allAmountElements.length} elements with class "amount":`);
            allAmountElements.forEach((el, i) => {
              console.log(`  ${i}: text="${el.textContent.trim()}" - data-v="${el.getAttribute('data-v-6cf5705a')}"`);
            });
          }
        }
        
        // -------------------------
        // 6. Enhanced Initialization with Persistence
        // -------------------------
        function initializeScript() {
          console.log("🚀 [Init] Initializing script with persistence...");
          
          // Detect current page type
          const currentPage = detectCurrentPage();
          
          // Start continuous monitoring immediately
          startContinuousMonitoring();
          
          // Setup mutation observer for amount element
          setupAmountObserver();
          
          // Start retry mechanism for amount element
          setTimeout(() => {
            retryAmountUpdate(15, 2000); // 15 attempts, 2 second delay
          }, 3000);
          
          // Add delayed update after page load
          setTimeout(() => {
            console.log("⏰ [Delayed] Starting delayed amount update after page load...");
            updateAmountElementDelayed();
          }, 2000);
          
          // Wait a bit for the page to fully load
          setTimeout(() => {
            if (currentPage === 'TeamReport') {
              console.log("🔄 [Init] Initializing Team Report page...");
            startDateWatcher();
            
            // Test immediate date detection
            setTimeout(() => {
              console.log("🔄 [Init] Testing immediate date detection...");
              console.log("🔄 [Init] Looking for TeamReport__C-head-line2 container...");
              
              const container = document.querySelector('.TeamReport__C-head-line2');
              if (container) {
                console.log("✅ [Init] Found TeamReport__C-head-line2 container");
                console.log("📋 [Init] Container HTML:", container.outerHTML);
                
                // Try the specific selector first - target the second div (date) not first (All)
                const specificDateSpan = document.querySelector('.TeamReport__C-head-line2 div[data-v-10d1559c]:nth-child(2) span.default[data-v-10d1559c]');
                if (specificDateSpan) {
                  const text = specificDateSpan.textContent.trim();
                  console.log("📅 [Init] Found date span with specific selector:", text);
                  updateTeamReport(text);
                } else {
                  console.log("❌ [Init] Specific selector failed, trying fallback...");
                  // Fallback to checking all spans
                  const dateSpans = document.querySelectorAll('span');
                  dateSpans.forEach(span => {
                    const text = span.textContent.trim();
                    if (text !== "All" && text.match(/\d{4}-\d{2}-\d{2}/)) {
                      console.log("📅 [Init] Found date span:", text);
                      updateTeamReport(text);
                    }
                  });
                }
              } else {
                console.log("❌ [Init] TeamReport__C-head-line2 container not found");
                console.log("🔍 [Init] Available elements with data-v-10d1559c:");
                const elements = document.querySelectorAll('[data-v-10d1559c]');
                elements.forEach((el, index) => {
                  console.log(`  ${index}: ${el.tagName} - ${el.className} - "${el.textContent.trim()}"`);
                });
              }
            }, 2000);
            } else if (currentPage === 'Promotion') {
              console.log("🔄 [Init] Initializing Promotion page...");
              
              // Test immediate promotion data update
              setTimeout(() => {
                console.log("🔄 [Init] Testing immediate promotion data update...");
                const promotionSuccess = updatePromotionData();
                if (promotionSuccess) {
                  console.log("✅ [Init] Promotion data updated successfully");
                } else {
                  console.log("⚠️ [Init] No promotion data was updated");
                }
                
                // Also update commission data
                console.log("🔄 [Init] Testing immediate commission data update...");
                const commissionSuccess = updateCommissionData();
                if (commissionSuccess) {
                  console.log("✅ [Init] Commission data updated successfully");
                } else {
                  console.log("⚠️ [Init] No commission data was updated");
                }
              }, 1000);
            } else {
              console.log("🔄 [Init] Other page detected, no specific initialization needed");
            }
          }, 1000);
        }

        if (document.readyState === "loading") {
          document.addEventListener("DOMContentLoaded", initializeScript);
        } else {
          initializeScript();
        }

        // Handle page visibility changes (tab switch, refresh, etc.)
        document.addEventListener('visibilitychange', function() {
          if (!document.hidden) {
            console.log("👁️ [Visibility] Page became visible, re-initializing...");
            setTimeout(() => {
              initializeScript();
            }, 500);
            
            // Also add delayed update when page becomes visible
            setTimeout(() => {
              console.log("⏰ [Visibility] Delayed update after page became visible...");
              updateAmountElementDelayed();
            }, 2000);
          }
        });
        
        // Handle page focus (when user comes back to tab)
        window.addEventListener('focus', function() {
          console.log("🎯 [Focus] Window focused, checking data...");
          setTimeout(() => {
            const currentPage = detectCurrentPage();
            if (currentPage === 'TeamReport' || currentPage === 'Promotion') {
              startContinuousMonitoring();
            }
          }, 500);
        });
        
        // Handle beforeunload to clean up
        window.addEventListener('beforeunload', function() {
          stopContinuousMonitoring();
        });

        console.log("✅ [Injector] Script setup complete with persistence");
      })();
    """;

    await _controller.runJavaScript(jsScript);
    print("🎯 Enhanced script successfully injected into WebView");
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
