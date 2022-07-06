//
//  Alphabet.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 27/06/22.
//

enum Alphabet: String, CaseIterable {
    case a
    case b
    case c
    case d
    case e
    case f
    case g
    case h
    case i
    case j
    case k
    case l
    case m
    case n
    case o
    case p
    case q
    case r
    case s
    case t
    case u
    case v
    case w
    case x
    case y
    case z

    public var spellings: [String] {
        switch self {
        case .a:
            return ["a", "ah", "ak"]
        case .b:
            return ["b", "be", "beh", "bek"]
        case .c:
            return ["c", "ce", "ceh", "cek"]
        case .d:
            return ["d", "de", "deh", "dek"]
        case .e:
            return ["e", "eh", "ek"]
        case .f:
            return ["f", "ef"]
        case .g:
            return ["g", "ge", "geh", "gek"]
        case .h:
            return ["h", "ha", "hah", "hak"]
        case .i:
            return ["i", "ih", "ik"]
        case .j:
            return ["j", "je", "jeh", "jek"]
        case .k:
            return ["k", "ka", "kah", "kak"]
        case .l:
            return ["l", "el"]
        case .m:
            return ["m", "em"]
        case .n:
            return ["n", "en"]
        case .o:
            return ["o", "oh", "ok"]
        case .p:
            return ["p", "pe", "peh", "pek"]
        case .q:
            return ["q", "qi", "qih", "qik", "ki", "kih", "kik"]
        case .r:
            return ["r", "er"]
        case .s:
            return ["s", "es"]
        case .t:
            return ["t", "te", "teh", "tek"]
        case .u:
            return ["u", "uh", "uk"]
        case .v:
            return ["v", "ve", "veh", "vek"]
        case .w:
            return ["w", "we", "weh", "wek"]
        case .x:
            return ["x", "ex", "eks"]
        case .y:
            return ["y", "ye", "yeh", "yek"]
        case .z:
            return ["z", "zet", "zed"]
        }
    }
}
