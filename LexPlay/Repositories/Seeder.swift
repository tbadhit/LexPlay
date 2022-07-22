//
//  Seeder.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 01/07/22.
//

import CoreData
import SwiftUI

struct Seeder {
    func seedAll(context: NSManagedObjectContext) {
        seedAlphabet(context: context)
        seedAvatar(context: context)
    }

    func seedAlphabet(context: NSManagedObjectContext) {
        guard !UserDefaults.standard.seedAlphabet else { return }
//        initBothCaseAlphabet(context: context)
        initUppercaseAlphabet(context: context)
        initLowercaseAlphabet(context: context)

        save(context: context)

        UserDefaults.standard.seedAlphabet = true
    }

    func seedAvatar(context: NSManagedObjectContext) {
        guard !UserDefaults.standard.seedAvatar else { return }
        let lex = AvatarEntity(context: context)
        lex.uuid = UUID()
        lex.path = "lex"
        lex.name = "Lex"
        lex.timestamp = Date().timeIntervalSince1970

        let play = AvatarEntity(context: context)
        play.uuid = UUID()
        play.path = "play"
        play.name = "Play"
        play.timestamp = Date().timeIntervalSince1970

        save(context: context)

        UserDefaults.standard.seedAvatar = true
    }

    func seedDummy(context: NSManagedObjectContext) {
//        Add new User
        let avatar = AvatarEntity(context: context)
        avatar.uuid = UUID()
        avatar.path = "lex"
        avatar.timestamp = Date().timeIntervalSince1970
        let reminder = ReminderEntity(context: context)
        reminder.uuid = UUID()
        reminder.time = Date()
        reminder.timestamp = Date().timeIntervalSince1970
        let reminder2 = ReminderEntity(context: context)
        reminder2.uuid = UUID()
        reminder2.time = Date()
        reminder2.timestamp = Date().timeIntervalSince1970
        let user1 = UserEntity(context: context)
        user1.uuid = UUID()
        user1.name = "Invoker"
        user1.alphabets = []
        user1.avatar = avatar
        user1.reminder = reminder
        user1.timestamp = Date().timeIntervalSince1970
        let user2 = UserEntity(context: context)
        user2.uuid = UUID()
        user2.name = "Outvoker"
        user2.alphabets = []
        user2.avatar = avatar
        user2.reminder = reminder2
        user2.login = false
        user2.timestamp = Date().timeIntervalSince1970
        let lesson1 = LessonEntity(context: context)
        lesson1.uuid = UUID()
        lesson1.alphabets = []
        lesson1.name = "1"
        lesson1.user = user1
        lesson1.timestamp = Date().timeIntervalSince1970
        let lesson2 = LessonEntity(context: context)
        lesson2.uuid = UUID()
        lesson2.name = "2"
        lesson2.alphabets = []
        lesson2.user = user1
        lesson2.timestamp = Date().timeIntervalSince1970
        let lesson3 = LessonEntity(context: context)
        lesson3.uuid = UUID()
        lesson3.name = "3"
        lesson3.alphabets = []
        lesson3.user = user1
        lesson3.timestamp = Date().timeIntervalSince1970
        let lesson4 = LessonEntity(context: context)
        lesson4.uuid = UUID()
        lesson4.name = "4"
        lesson4.alphabets = []
        lesson4.user = user1
        lesson4.timestamp = Date().timeIntervalSince1970
        let lesson5 = LessonEntity(context: context)
        lesson5.uuid = UUID()
        lesson5.name = "5"
        lesson5.alphabets = []
        lesson5.user = user1
        lesson5.timestamp = Date().timeIntervalSince1970
        let a = AlphabetEntity(context: context)
        a.uuid = UUID()
        a.char = Alphabet.a.rawValue.uppercased()
        a.letterCase = Int16(LetterCase.upper.rawValue)
        a.timestamp = Date().timeIntervalSince1970
        let b = AlphabetEntity(context: context)
        b.uuid = UUID()
        b.char = Alphabet.b.rawValue.lowercased()
        b.letterCase = Int16(LetterCase.lower.rawValue)
        b.timestamp = Date().timeIntervalSince1970
        let userAlphabetA = UserAlphabetEntity(context: context)
        userAlphabetA.uuid = UUID()
        userAlphabetA.user = user1
        userAlphabetA.hasDifficulty = true
        userAlphabetA.lesson = lesson1
        userAlphabetA.alphabet = a
        userAlphabetA.imageAssociation = UIImage(named: "background")?.jpegData(compressionQuality: .infinity)
        userAlphabetA.timestamp = Date().timeIntervalSince1970
        let userAlphabetB = UserAlphabetEntity(context: context)
        userAlphabetB.uuid = UUID()
        userAlphabetB.user = user1
        userAlphabetB.hasDifficulty = true
        userAlphabetB.lesson = lesson1
        userAlphabetB.alphabet = b
        userAlphabetB.timestamp = Date().timeIntervalSince1970
        save(context: context)
    }
}

extension Seeder {
    private func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Failed to save alphabets: \(nsError), \(nsError.userInfo)")
        }
    }

    private func initBothCaseAlphabet(context: NSManagedObjectContext) {
        let a = AlphabetEntity(context: context)
        a.uuid = UUID()
        a.char = Alphabet.a.rawValue
        a.letterCase = Int16(LetterCase.both.rawValue)
        a.timestamp = Date().timeIntervalSince1970

        let b = AlphabetEntity(context: context)
        b.uuid = UUID()
        b.char = Alphabet.b.rawValue
        b.letterCase = Int16(LetterCase.both.rawValue)
        b.timestamp = Date().timeIntervalSince1970

        let c = AlphabetEntity(context: context)
        c.uuid = UUID()
        c.char = Alphabet.c.rawValue
        c.letterCase = Int16(LetterCase.both.rawValue)
        c.timestamp = Date().timeIntervalSince1970

        let d = AlphabetEntity(context: context)
        d.uuid = UUID()
        d.char = Alphabet.d.rawValue
        d.letterCase = Int16(LetterCase.both.rawValue)
        d.timestamp = Date().timeIntervalSince1970

        let e = AlphabetEntity(context: context)
        e.uuid = UUID()
        e.char = Alphabet.e.rawValue
        e.letterCase = Int16(LetterCase.both.rawValue)
        e.timestamp = Date().timeIntervalSince1970

        let f = AlphabetEntity(context: context)
        f.uuid = UUID()
        f.char = Alphabet.f.rawValue
        f.letterCase = Int16(LetterCase.both.rawValue)
        f.timestamp = Date().timeIntervalSince1970

        let g = AlphabetEntity(context: context)
        g.uuid = UUID()
        g.char = Alphabet.g.rawValue
        g.letterCase = Int16(LetterCase.both.rawValue)
        g.timestamp = Date().timeIntervalSince1970

        let h = AlphabetEntity(context: context)
        h.uuid = UUID()
        h.char = Alphabet.h.rawValue
        h.letterCase = Int16(LetterCase.both.rawValue)
        h.timestamp = Date().timeIntervalSince1970

        let i = AlphabetEntity(context: context)
        i.uuid = UUID()
        i.char = Alphabet.i.rawValue
        i.letterCase = Int16(LetterCase.both.rawValue)
        i.timestamp = Date().timeIntervalSince1970

        let j = AlphabetEntity(context: context)
        j.uuid = UUID()
        j.char = Alphabet.j.rawValue
        j.letterCase = Int16(LetterCase.both.rawValue)
        j.timestamp = Date().timeIntervalSince1970

        let k = AlphabetEntity(context: context)
        k.uuid = UUID()
        k.char = Alphabet.k.rawValue
        k.letterCase = Int16(LetterCase.both.rawValue)
        k.timestamp = Date().timeIntervalSince1970

        let l = AlphabetEntity(context: context)
        l.uuid = UUID()
        l.char = Alphabet.l.rawValue
        l.letterCase = Int16(LetterCase.both.rawValue)
        l.timestamp = Date().timeIntervalSince1970

        let m = AlphabetEntity(context: context)
        m.uuid = UUID()
        m.char = Alphabet.m.rawValue
        m.letterCase = Int16(LetterCase.both.rawValue)
        m.timestamp = Date().timeIntervalSince1970

        let n = AlphabetEntity(context: context)
        n.uuid = UUID()
        n.char = Alphabet.n.rawValue
        n.letterCase = Int16(LetterCase.both.rawValue)
        n.timestamp = Date().timeIntervalSince1970

        let o = AlphabetEntity(context: context)
        o.uuid = UUID()
        o.char = Alphabet.o.rawValue
        o.letterCase = Int16(LetterCase.both.rawValue)
        o.timestamp = Date().timeIntervalSince1970

        let p = AlphabetEntity(context: context)
        p.uuid = UUID()
        p.char = Alphabet.p.rawValue
        p.letterCase = Int16(LetterCase.both.rawValue)
        p.timestamp = Date().timeIntervalSince1970

        let q = AlphabetEntity(context: context)
        q.uuid = UUID()
        q.char = Alphabet.q.rawValue
        q.letterCase = Int16(LetterCase.both.rawValue)
        q.timestamp = Date().timeIntervalSince1970

        let r = AlphabetEntity(context: context)
        r.uuid = UUID()
        r.char = Alphabet.r.rawValue
        r.letterCase = Int16(LetterCase.both.rawValue)
        r.timestamp = Date().timeIntervalSince1970

        let s = AlphabetEntity(context: context)
        s.uuid = UUID()
        s.char = Alphabet.s.rawValue
        s.letterCase = Int16(LetterCase.both.rawValue)
        s.timestamp = Date().timeIntervalSince1970

        let t = AlphabetEntity(context: context)
        t.uuid = UUID()
        t.char = Alphabet.t.rawValue
        t.letterCase = Int16(LetterCase.both.rawValue)
        t.timestamp = Date().timeIntervalSince1970

        let u = AlphabetEntity(context: context)
        u.uuid = UUID()
        u.char = Alphabet.u.rawValue
        u.letterCase = Int16(LetterCase.both.rawValue)
        u.timestamp = Date().timeIntervalSince1970

        let v = AlphabetEntity(context: context)
        v.uuid = UUID()
        v.char = Alphabet.v.rawValue
        v.letterCase = Int16(LetterCase.both.rawValue)
        v.timestamp = Date().timeIntervalSince1970

        let w = AlphabetEntity(context: context)
        w.uuid = UUID()
        w.char = Alphabet.w.rawValue
        w.letterCase = Int16(LetterCase.both.rawValue)
        w.timestamp = Date().timeIntervalSince1970

        let x = AlphabetEntity(context: context)
        x.uuid = UUID()
        x.char = Alphabet.x.rawValue
        x.letterCase = Int16(LetterCase.both.rawValue)
        x.timestamp = Date().timeIntervalSince1970

        let y = AlphabetEntity(context: context)
        y.uuid = UUID()
        y.char = Alphabet.y.rawValue
        y.letterCase = Int16(LetterCase.both.rawValue)
        y.timestamp = Date().timeIntervalSince1970

        let z = AlphabetEntity(context: context)
        z.uuid = UUID()
        z.char = Alphabet.z.rawValue
        z.letterCase = Int16(LetterCase.both.rawValue)
        z.timestamp = Date().timeIntervalSince1970
    }

    private func initUppercaseAlphabet(context: NSManagedObjectContext) {
        let a = AlphabetEntity(context: context)
        a.uuid = UUID()
        a.char = Alphabet.a.rawValue.uppercased()
        a.letterCase = Int16(LetterCase.upper.rawValue)
        a.timestamp = Date().timeIntervalSince1970

        let b = AlphabetEntity(context: context)
        b.uuid = UUID()
        b.char = Alphabet.b.rawValue.uppercased()
        b.letterCase = Int16(LetterCase.upper.rawValue)
        b.timestamp = Date().timeIntervalSince1970

        let c = AlphabetEntity(context: context)
        c.uuid = UUID()
        c.char = Alphabet.c.rawValue.uppercased()
        c.letterCase = Int16(LetterCase.upper.rawValue)
        c.timestamp = Date().timeIntervalSince1970

        let d = AlphabetEntity(context: context)
        d.uuid = UUID()
        d.char = Alphabet.d.rawValue.uppercased()
        d.letterCase = Int16(LetterCase.upper.rawValue)
        d.timestamp = Date().timeIntervalSince1970

        let e = AlphabetEntity(context: context)
        e.uuid = UUID()
        e.char = Alphabet.e.rawValue.uppercased()
        e.letterCase = Int16(LetterCase.upper.rawValue)
        e.timestamp = Date().timeIntervalSince1970

        let f = AlphabetEntity(context: context)
        f.uuid = UUID()
        f.char = Alphabet.f.rawValue.uppercased()
        f.letterCase = Int16(LetterCase.upper.rawValue)
        f.timestamp = Date().timeIntervalSince1970

        let g = AlphabetEntity(context: context)
        g.uuid = UUID()
        g.char = Alphabet.g.rawValue.uppercased()
        g.letterCase = Int16(LetterCase.upper.rawValue)
        g.timestamp = Date().timeIntervalSince1970

        let h = AlphabetEntity(context: context)
        h.uuid = UUID()
        h.char = Alphabet.h.rawValue.uppercased()
        h.letterCase = Int16(LetterCase.upper.rawValue)
        h.timestamp = Date().timeIntervalSince1970

        let i = AlphabetEntity(context: context)
        i.uuid = UUID()
        i.char = Alphabet.i.rawValue.uppercased()
        i.letterCase = Int16(LetterCase.upper.rawValue)
        i.timestamp = Date().timeIntervalSince1970

        let j = AlphabetEntity(context: context)
        j.uuid = UUID()
        j.char = Alphabet.j.rawValue.uppercased()
        j.letterCase = Int16(LetterCase.upper.rawValue)
        j.timestamp = Date().timeIntervalSince1970

        let k = AlphabetEntity(context: context)
        k.uuid = UUID()
        k.char = Alphabet.k.rawValue.uppercased()
        k.letterCase = Int16(LetterCase.upper.rawValue)
        k.timestamp = Date().timeIntervalSince1970

        let l = AlphabetEntity(context: context)
        l.uuid = UUID()
        l.char = Alphabet.l.rawValue.uppercased()
        l.letterCase = Int16(LetterCase.upper.rawValue)
        l.timestamp = Date().timeIntervalSince1970

        let m = AlphabetEntity(context: context)
        m.uuid = UUID()
        m.char = Alphabet.m.rawValue.uppercased()
        m.letterCase = Int16(LetterCase.upper.rawValue)
        m.timestamp = Date().timeIntervalSince1970

        let n = AlphabetEntity(context: context)
        n.uuid = UUID()
        n.char = Alphabet.n.rawValue.uppercased()
        n.letterCase = Int16(LetterCase.upper.rawValue)
        n.timestamp = Date().timeIntervalSince1970

        let o = AlphabetEntity(context: context)
        o.uuid = UUID()
        o.char = Alphabet.o.rawValue.uppercased()
        o.letterCase = Int16(LetterCase.upper.rawValue)
        o.timestamp = Date().timeIntervalSince1970

        let p = AlphabetEntity(context: context)
        p.uuid = UUID()
        p.char = Alphabet.p.rawValue.uppercased()
        p.letterCase = Int16(LetterCase.upper.rawValue)
        p.timestamp = Date().timeIntervalSince1970

        let q = AlphabetEntity(context: context)
        q.uuid = UUID()
        q.char = Alphabet.q.rawValue.uppercased()
        q.letterCase = Int16(LetterCase.upper.rawValue)
        q.timestamp = Date().timeIntervalSince1970

        let r = AlphabetEntity(context: context)
        r.uuid = UUID()
        r.char = Alphabet.r.rawValue.uppercased()
        r.letterCase = Int16(LetterCase.upper.rawValue)
        r.timestamp = Date().timeIntervalSince1970

        let s = AlphabetEntity(context: context)
        s.uuid = UUID()
        s.char = Alphabet.s.rawValue.uppercased()
        s.letterCase = Int16(LetterCase.upper.rawValue)
        s.timestamp = Date().timeIntervalSince1970

        let t = AlphabetEntity(context: context)
        t.uuid = UUID()
        t.char = Alphabet.t.rawValue.uppercased()
        t.letterCase = Int16(LetterCase.upper.rawValue)
        t.timestamp = Date().timeIntervalSince1970

        let u = AlphabetEntity(context: context)
        u.uuid = UUID()
        u.char = Alphabet.u.rawValue.uppercased()
        u.letterCase = Int16(LetterCase.upper.rawValue)
        u.timestamp = Date().timeIntervalSince1970

        let v = AlphabetEntity(context: context)
        v.uuid = UUID()
        v.char = Alphabet.v.rawValue.uppercased()
        v.letterCase = Int16(LetterCase.upper.rawValue)
        v.timestamp = Date().timeIntervalSince1970

        let w = AlphabetEntity(context: context)
        w.uuid = UUID()
        w.char = Alphabet.w.rawValue.uppercased()
        w.letterCase = Int16(LetterCase.upper.rawValue)
        w.timestamp = Date().timeIntervalSince1970

        let x = AlphabetEntity(context: context)
        x.uuid = UUID()
        x.char = Alphabet.x.rawValue.uppercased()
        x.letterCase = Int16(LetterCase.upper.rawValue)
        x.timestamp = Date().timeIntervalSince1970

        let y = AlphabetEntity(context: context)
        y.uuid = UUID()
        y.char = Alphabet.y.rawValue.uppercased()
        y.letterCase = Int16(LetterCase.upper.rawValue)
        y.timestamp = Date().timeIntervalSince1970

        let z = AlphabetEntity(context: context)
        z.uuid = UUID()
        z.char = Alphabet.z.rawValue.uppercased()
        z.letterCase = Int16(LetterCase.upper.rawValue)
        z.timestamp = Date().timeIntervalSince1970
    }

    private func initLowercaseAlphabet(context: NSManagedObjectContext) {
        let a = AlphabetEntity(context: context)
        a.uuid = UUID()
        a.char = Alphabet.a.rawValue.lowercased()
        a.letterCase = Int16(LetterCase.lower.rawValue)
        a.timestamp = Date().timeIntervalSince1970

        let b = AlphabetEntity(context: context)
        b.uuid = UUID()
        b.char = Alphabet.b.rawValue.lowercased()
        b.letterCase = Int16(LetterCase.lower.rawValue)
        b.timestamp = Date().timeIntervalSince1970

        let c = AlphabetEntity(context: context)
        c.uuid = UUID()
        c.char = Alphabet.c.rawValue.lowercased()
        c.letterCase = Int16(LetterCase.lower.rawValue)
        c.timestamp = Date().timeIntervalSince1970

        let d = AlphabetEntity(context: context)
        d.uuid = UUID()
        d.char = Alphabet.d.rawValue.lowercased()
        d.letterCase = Int16(LetterCase.lower.rawValue)
        d.timestamp = Date().timeIntervalSince1970

        let e = AlphabetEntity(context: context)
        e.uuid = UUID()
        e.char = Alphabet.e.rawValue.lowercased()
        e.letterCase = Int16(LetterCase.lower.rawValue)
        e.timestamp = Date().timeIntervalSince1970

        let f = AlphabetEntity(context: context)
        f.uuid = UUID()
        f.char = Alphabet.f.rawValue.lowercased()
        f.letterCase = Int16(LetterCase.lower.rawValue)
        f.timestamp = Date().timeIntervalSince1970

        let g = AlphabetEntity(context: context)
        g.uuid = UUID()
        g.char = Alphabet.g.rawValue.lowercased()
        g.letterCase = Int16(LetterCase.lower.rawValue)
        g.timestamp = Date().timeIntervalSince1970

        let h = AlphabetEntity(context: context)
        h.uuid = UUID()
        h.char = Alphabet.h.rawValue.lowercased()
        h.letterCase = Int16(LetterCase.lower.rawValue)
        h.timestamp = Date().timeIntervalSince1970

        let i = AlphabetEntity(context: context)
        i.uuid = UUID()
        i.char = Alphabet.i.rawValue.lowercased()
        i.letterCase = Int16(LetterCase.lower.rawValue)
        i.timestamp = Date().timeIntervalSince1970

        let j = AlphabetEntity(context: context)
        j.uuid = UUID()
        j.char = Alphabet.j.rawValue.lowercased()
        j.letterCase = Int16(LetterCase.lower.rawValue)
        j.timestamp = Date().timeIntervalSince1970

        let k = AlphabetEntity(context: context)
        k.uuid = UUID()
        k.char = Alphabet.k.rawValue.lowercased()
        k.letterCase = Int16(LetterCase.lower.rawValue)
        k.timestamp = Date().timeIntervalSince1970

        let l = AlphabetEntity(context: context)
        l.uuid = UUID()
        l.char = Alphabet.l.rawValue.lowercased()
        l.letterCase = Int16(LetterCase.lower.rawValue)
        l.timestamp = Date().timeIntervalSince1970

        let m = AlphabetEntity(context: context)
        m.uuid = UUID()
        m.char = Alphabet.m.rawValue.lowercased()
        m.letterCase = Int16(LetterCase.lower.rawValue)
        m.timestamp = Date().timeIntervalSince1970

        let n = AlphabetEntity(context: context)
        n.uuid = UUID()
        n.char = Alphabet.n.rawValue.lowercased()
        n.letterCase = Int16(LetterCase.lower.rawValue)
        n.timestamp = Date().timeIntervalSince1970

        let o = AlphabetEntity(context: context)
        o.uuid = UUID()
        o.char = Alphabet.o.rawValue.lowercased()
        o.letterCase = Int16(LetterCase.lower.rawValue)
        o.timestamp = Date().timeIntervalSince1970

        let p = AlphabetEntity(context: context)
        p.uuid = UUID()
        p.char = Alphabet.p.rawValue.lowercased()
        p.letterCase = Int16(LetterCase.lower.rawValue)
        p.timestamp = Date().timeIntervalSince1970

        let q = AlphabetEntity(context: context)
        q.uuid = UUID()
        q.char = Alphabet.q.rawValue.lowercased()
        q.letterCase = Int16(LetterCase.lower.rawValue)
        q.timestamp = Date().timeIntervalSince1970

        let r = AlphabetEntity(context: context)
        r.uuid = UUID()
        r.char = Alphabet.r.rawValue.lowercased()
        r.letterCase = Int16(LetterCase.lower.rawValue)
        r.timestamp = Date().timeIntervalSince1970

        let s = AlphabetEntity(context: context)
        s.uuid = UUID()
        s.char = Alphabet.s.rawValue.lowercased()
        s.letterCase = Int16(LetterCase.lower.rawValue)
        s.timestamp = Date().timeIntervalSince1970

        let t = AlphabetEntity(context: context)
        t.uuid = UUID()
        t.char = Alphabet.t.rawValue.lowercased()
        t.letterCase = Int16(LetterCase.lower.rawValue)
        t.timestamp = Date().timeIntervalSince1970

        let u = AlphabetEntity(context: context)
        u.uuid = UUID()
        u.char = Alphabet.u.rawValue.lowercased()
        u.letterCase = Int16(LetterCase.lower.rawValue)
        u.timestamp = Date().timeIntervalSince1970

        let v = AlphabetEntity(context: context)
        v.uuid = UUID()
        v.char = Alphabet.v.rawValue.lowercased()
        v.letterCase = Int16(LetterCase.lower.rawValue)
        v.timestamp = Date().timeIntervalSince1970

        let w = AlphabetEntity(context: context)
        w.uuid = UUID()
        w.char = Alphabet.w.rawValue.lowercased()
        w.letterCase = Int16(LetterCase.lower.rawValue)
        w.timestamp = Date().timeIntervalSince1970

        let x = AlphabetEntity(context: context)
        x.uuid = UUID()
        x.char = Alphabet.x.rawValue.lowercased()
        x.letterCase = Int16(LetterCase.lower.rawValue)
        x.timestamp = Date().timeIntervalSince1970

        let y = AlphabetEntity(context: context)
        y.uuid = UUID()
        y.char = Alphabet.y.rawValue.lowercased()
        y.letterCase = Int16(LetterCase.lower.rawValue)
        y.timestamp = Date().timeIntervalSince1970

        let z = AlphabetEntity(context: context)
        z.uuid = UUID()
        z.char = Alphabet.z.rawValue.lowercased()
        z.letterCase = Int16(LetterCase.lower.rawValue)
        z.timestamp = Date().timeIntervalSince1970
    }
}
