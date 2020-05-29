//
//  VisionAPIModel.swift
//  GoogleVisionKit
//
//  Created by mnfro on 05/2020.
//  Copyright © 2020 Manfredi Schiera (@mnfro). All rights reserved.
//

import Foundation

struct VisionKit: Codable {
    var responses : [Response]?
}

struct Response: Codable {
    var fullTextAnnotation : FullTextAnnotation?
    
    struct FullTextAnnotation: Codable {
        var text : String?
        var pages : [Page]?
        
        struct Page: Codable {
            var blocks : [Block]?
            
            struct Block: Codable {
                var paragraphs : [Paragraph]?

                struct Paragraph: Codable {
                    var words : [Word]?
                    
                    struct Word: Codable {
                        var symbols : [Symbol]?
                        
                        struct Symbol: Codable {
                            var text : String?
                            var property : Property?
                            
                            struct Property: Codable {
                                var detectedBreak : DetectedBreak?
                                
                                struct DetectedBreak: Codable {
                                    var type : String?
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
}

extension Response {
    
    var parseText: [String] {
        var paragraphs: [String] = []
        var lines: [String] = []
        for page in (fullTextAnnotation?.pages)! {
            for block in (page.blocks)! {
                var block_paragraph = ""
                for paragraph in (block.paragraphs)! {
                    var para = ""
                    var line = ""
                    for word in (paragraph.words)! {
                        for symbol in (word.symbols)! {
                            line += (symbol.text)!
                            if symbol.property?.detectedBreak?.type == "SPACE" {
                                line += " "
                            }
                            if symbol.property?.detectedBreak?.type == "EOL_SURE_SPACE" {
                                line += " "
                                lines.append(line)
                                para += line
                                line = ""
                            }
                            if symbol.property?.detectedBreak?.type == "LINE_BREAK" {
                                lines.append(line)
                                para += line
                                line = ""
                            }
                        }
                    }
                    block_paragraph += para
                }
                paragraphs.append(block_paragraph)
            }
        }
        return paragraphs
    }
    
}
