import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const String defaultUrl =
      'https://bharatwinn.site/#/register?invitationCode=7729082258040';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: _WebViewScreen(initialUrl: defaultUrl)),
      ),
    );
  }
}

class _WebViewScreen extends StatefulWidget {
  const _WebViewScreen({required this.initialUrl});

  final String initialUrl;

  @override
  State<_WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<_WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            _injectReplacementScript();
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  void _injectReplacementScript() {
    const script = r'''
      (function() {
        'use strict';
        
        // Global state management
        let isInitialized = false;
        let lastDate = '';
        let retryCount = 0;
        let maxRetries = 10;
        let isRunning = false;
        
        // Enhanced value mappings with fallbacks
        const valueMappings = {
          // Direct subordinates
          'direct': {
            'number of register': '52',
            'Deposit number': '52',
            'Deposit amount': '26632',
            'Number of people making first deposit': '13'
          },
          // Team subordinates
          'team': {
            'number of register': '2',
            'Deposit number': '1',
            'Deposit amount': '2100',
            'Number of people making first deposit': '1'
          },
          // Promotion data
          'promotion': {
            'This Week': '251.58',
            'Total commission': '11464.89',
            'direct subordinate': '2465',
            'Total number of subordinates in the team': '145'
          },
          // Team Report dates
          'dates': {
            '2025-08-29': {
              'Deposit number': '61',
              'Deposit amount': '33026',
              'Number of bettors': '80',
              'Total bet': '150217',
              'Number of people making first deposit': '16',
              'First deposit amount': '13455'
            },
            '2025-08-28': {
              'Deposit number': '62',
              'Deposit amount': '34124',
              'Number of bettors': '75',
              'Total bet': '163823',
              'Number of people making first deposit': '19',
              'First deposit amount': '14524'
            },
            '2025-08-27': {
              'Deposit number': '70',
              'Deposit amount': '40585',
              'Number of bettors': '76',
              'Total bet': '245767',
              'Number of people making first deposit': '19',
              'First deposit amount': '21119'
            },
            '2025-08-26': {
              'Deposit number': '61',
              'Deposit amount': '44363',
              'Number of bettors': '74',
              'Total bet': '187832',
              'Number of people making first deposit': '26',
              'First deposit amount': '23885'
            },
            '2025-08-25': {
              'Deposit number': '70',
              'Deposit amount': '43468',
              'Number of bettors': '80',
              'Total bet': '191321',
              'Number of people making first deposit': '33',
              'First deposit amount': '18347'
            },
            '2025-08-24': {
              'Deposit number': '66',
              'Deposit amount': '30045',
              'Number of bettors': '81',
              'Total bet': '191924',
              'Number of people making first deposit': '29',
              'First deposit amount': '14402'
            },
            '2025-08-23': {
              'Deposit number': '63',
              'Deposit amount': '40824',
              'Number of bettors': '78',
              'Total bet': '256046',
              'Number of people making first deposit': '29',
              'First deposit amount': '20954'
            },
            '2025-08-22': {
              'Deposit number': '51',
              'Deposit amount': '23934',
              'Number of bettors': '62',
              'Total bet': '132607',
              'Number of people making first deposit': '15',
              'First deposit amount': '11774'
            },
            '2025-08-21': {
              'Deposit number': '51',
              'Deposit amount': '22181',
              'Number of bettors': '62',
              'Total bet': '124103',
              'Number of people making first deposit': '14',
              'First deposit amount': '9241'
            },
            '2025-08-20': {
              'Deposit number': '52',
              'Deposit amount': '26632',
              'Number of bettors': '72',
              'Total bet': '129343',
              'Number of people making first deposit': '13',
              'First deposit amount': '11636'
            }
          }
        };
        
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
        
        // Core replacement function
        function replaceValues() {
          if (isRunning) return; // Prevent overlapping executions
          isRunning = true;
          
          try {
            // Phase 1: Handle Direct and Team subordinates
            const infoDivs = safeQuerySelectorAll('.info');
            if (infoDivs.length > 0) {
              infoDivs.forEach(infoDiv => {
                try {
                  const lineDivs = safeQuerySelectorAll('.line1, .line2, .line3', infoDiv);
                  lineDivs.forEach(lineDiv => {
                    try {
                      const numberDiv = safeQuerySelector('div', lineDiv);
                      if (numberDiv && safeTextContent(numberDiv) === '0') {
                        const textContent = safeTextContent(lineDiv);
                        
                        // Determine if it's team section
                        const isTeamSection = safeQuerySelector('.head.u2', infoDiv) !== null;
                        const mapping = isTeamSection ? valueMappings.team : valueMappings.direct;
                        
                        // Apply appropriate values
                        Object.entries(mapping).forEach(([key, value]) => {
                          if (textContent.includes(key)) {
                            numberDiv.textContent = value;
                          }
                        });
                      }
                    } catch (e) {
                      // Individual line error - continue with others
                    }
                  });
                } catch (e) {
                  // Individual info div error - continue with others
                }
              });
            }
            
            // Phase 1.5: Handle Promotion Data
            const commissionDiv = safeQuerySelector('.commission');
            if (commissionDiv) {
              try {
                const commissionBodyDivs = safeQuerySelectorAll('.commission__body', commissionDiv);
                commissionBodyDivs.forEach(bodyDiv => {
                  try {
                    const spans = safeQuerySelectorAll('span', bodyDiv);
                    spans.forEach(span => {
                      try {
                        const spanText = safeTextContent(span);
                        if (spanText === '0') {
                          // Find the label span (the one with descriptive text)
                          const labelSpan = Array.from(spans).find(s => 
                            safeTextContent(s) !== '0' && 
                            safeTextContent(s) !== '' &&
                            !safeTextContent(s).match(/^\d+\.?\d*$/)
                          );
                          
                          if (labelSpan) {
                            const label = safeTextContent(labelSpan);
                            // Apply promotion data values
                            Object.entries(valueMappings.promotion).forEach(([key, value]) => {
                              if (label.includes(key)) {
                                span.textContent = value;
                              }
                            });
                          }
                        }
                      } catch (e) {
                        // Individual span error - continue with others
                      }
                    });
                  } catch (e) {
                    // Individual body div error - continue with others
                  }
                });
              } catch (e) {
                // Promotion data error - continue
              }
            }
            
                         // Phase 2: Handle Team Report page
             const headerContainer = safeQuerySelector('.header-container');
             if (headerContainer) {
               try {
                 // Get current date with multiple selectors for better detection
                 let dateSpan = safeQuerySelector('span.default');
                 if (!dateSpan) {
                   // Try alternative selectors
                   dateSpan = safeQuerySelector('[data-v-10d1559c].default');
                   if (!dateSpan) {
                     dateSpan = safeQuerySelector('span[class*="default"]');
                   }
                 }
                 
                 let selectedDate = '2025-08-26';
                 
                 if (dateSpan) {
                   const dateText = safeTextContent(dateSpan);
                   console.log('Found date:', dateText);
                   
                   if (dateText && valueMappings.dates[dateText]) {
                     selectedDate = dateText;
                     console.log('Using date:', selectedDate);
                   } else {
                     console.log('Date not found in mappings, using default');
                   }
                 } else {
                   console.log('No date span found');
                 }
                 
                 const currentValues = valueMappings.dates[selectedDate] || valueMappings.dates['2025-08-26'];
                 console.log('Current values for date', selectedDate, ':', currentValues);
                 
                 // Replace header values more aggressively
                 const numDivs = safeQuerySelectorAll('.num', headerContainer);
                 console.log('Found', numDivs.length, 'num divs');
                 
                 numDivs.forEach((numDiv, index) => {
                   try {
                     const currentText = safeTextContent(numDiv);
                     console.log('Num div', index, 'current text:', currentText);
                     
                     if (currentText === '0' || currentText === '') {
                       const parentDiv = numDiv.parentElement;
                       if (parentDiv) {
                         const textContent = safeTextContent(parentDiv);
                         console.log('Parent text:', textContent);
                         
                         // More specific matching
                         let matched = false;
                         Object.entries(currentValues).forEach(([key, value]) => {
                           if (textContent.includes(key)) {
                             numDiv.textContent = value;
                             console.log('Updated', key, 'to', value);
                             matched = true;
                           }
                         });
                         
                         if (!matched) {
                           // Fallback: try to match by position/index
                           const keys = Object.keys(currentValues);
                           if (index < keys.length) {
                             const key = keys[index];
                             const value = currentValues[key];
                             numDiv.textContent = value;
                             console.log('Fallback update by index', index, ':', key, '=', value);
                           }
                         }
                       }
                     }
                   } catch (e) {
                     console.log('Error updating num div', index, ':', e);
                   }
                 });
                 
                 // Update last known date
                 lastDate = selectedDate;
                 
               } catch (e) {
                 console.log('Team Report error:', e);
               }
             }
            
            // Phase 3: Aggressive fallback replacement
            try {
              const allZeroDivs = safeQuerySelectorAll('div');
              allZeroDivs.forEach(div => {
                try {
                  if (safeTextContent(div) === '0') {
                    const parentText = safeTextContent(div.parentElement);
                    if (parentText) {
                      // Apply fallback values based on context
                      if (parentText.includes('number of register')) {
                        div.textContent = '25';
                      } else if (parentText.includes('Deposit number')) {
                        div.textContent = '18';
                      } else if (parentText.includes('Deposit amount')) {
                        div.textContent = '15000';
                      } else if (parentText.includes('Number of people making first deposit')) {
                        div.textContent = '12';
                      }
                    }
                  }
                } catch (e) {
                  // Individual div error - continue with others
                }
              });
            } catch (e) {
              // Fallback phase error - continue
            }
            
            // Mark as initialized
            isInitialized = true;
            retryCount = 0;
            
          } catch (error) {
            console.log('Replace values error:', error);
            retryCount++;
          } finally {
            isRunning = false;
          }
        }
        
        // Smart initialization
        function initialize() {
          if (isInitialized && retryCount === 0) return;
          
          const body = safeQuerySelector('body');
          if (body) {
            replaceValues();
          } else if (retryCount < maxRetries) {
            retryCount++;
            setTimeout(initialize, 500);
          }
        }
        
                 // Enhanced monitoring
         function startMonitoring() {
           // Initial run
           setTimeout(initialize, 500);
           
           // Periodic refresh
           setInterval(() => {
             if (!isRunning) {
               replaceValues();
             }
           }, 1500);
           
           // Force refresh when URL changes (for navigation)
           let lastUrl = window.location.href;
           setInterval(() => {
             if (window.location.href !== lastUrl) {
               lastUrl = window.location.href;
               console.log('URL changed, forcing refresh');
               setTimeout(replaceValues, 200);
             }
           }, 300);
          
                     // Date change monitoring - more aggressive
           setInterval(() => {
             try {
               let dateSpan = safeQuerySelector('span.default');
               if (!dateSpan) {
                 dateSpan = safeQuerySelector('[data-v-10d1559c].default');
                 if (!dateSpan) {
                   dateSpan = safeQuerySelector('span[class*="default"]');
                 }
               }
               
               if (dateSpan) {
                 const currentDate = safeTextContent(dateSpan);
                 if (currentDate && currentDate !== lastDate) {
                   lastDate = currentDate;
                   console.log('Date changed to:', currentDate);
                   // Immediate update for date changes
                   setTimeout(replaceValues, 50);
                 }
               }
             } catch (e) {
               // Date monitoring error - continue
             }
           }, 500); // Check more frequently
          
          // DOM change monitoring
          try {
            const observer = new MutationObserver((mutations) => {
              if (!isRunning && mutations.some(m => m.type === 'childList')) {
                setTimeout(replaceValues, 200);
              }
            });
            
            observer.observe(document.body, {
              childList: true,
              subtree: true,
              childList: true
            });
          } catch (e) {
            // Observer error - fallback to interval
          }
        }
        
        // Start the system
        if (document.readyState === 'loading') {
          document.addEventListener('DOMContentLoaded', startMonitoring);
        } else {
          startMonitoring();
        }
        
        // Fallback for late loading
        window.addEventListener('load', () => {
          if (!isInitialized) {
            setTimeout(initialize, 1000);
          }
        });
        
      })();
    ''';

    _controller.runJavaScript(script);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
