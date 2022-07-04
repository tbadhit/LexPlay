//
//  Seeder.swift
//  LexPlay
//
//  Created by Muhamad Fahmi Al Kautsar on 01/07/22.
//

import CoreData

struct Seeder {
    func seedAlphabet(context: NSManagedObjectContext) {
        guard !UserDefaults.standard.seedAlphabet else { return }
//        initBothCaseAlphabet(context: context)
        initUppercaseAlphabet(context: context)
        initLowercaseAlphabet(context: context)

        save(context: context)

        UserDefaults.standard.seedAlphabet = true
    }

    func seedDummy(context: NSManagedObjectContext) {
//        Add new User
        let avatar = AvatarEntity(context: context)
        avatar.uuid = UUID()
        avatar.path = "lex"
        let reminder = ReminderEntity(context: context)
        reminder.uuid = UUID()
        reminder.time = Date()
        let user = UserEntity(context: context)
        user.uuid = UUID()
        user.name = "Invoker"
        user.alphabets = []
        user.avatar = avatar
        user.reminder = reminder
        let lesson1 = LessonEntity(context: context)
        lesson1.uuid = UUID()
        lesson1.alphabets = []
        lesson1.name = "1"
        lesson1.user = user
        let lesson2 = LessonEntity(context: context)
        lesson2.uuid = UUID()
        lesson2.name = "2"
        lesson2.alphabets = []
        lesson2.user = user
        let lesson3 = LessonEntity(context: context)
        lesson3.uuid = UUID()
        lesson3.name = "3"
        lesson3.alphabets = []
        lesson3.user = user
        let lesson4 = LessonEntity(context: context)
        lesson4.uuid = UUID()
        lesson4.name = "4"
        lesson4.alphabets = []
        lesson4.user = user
        let lesson5 = LessonEntity(context: context)
        lesson5.uuid = UUID()
        lesson5.name = "5"
        lesson5.alphabets = []
        lesson5.user = user
        let a = AlphabetEntity(context: context)
        a.uuid = UUID()
        a.char = Alphabet.a.rawValue
        a.letterCase = Int16(LetterCase.upper.rawValue)
        let b = AlphabetEntity(context: context)
        b.uuid = UUID()
        b.char = Alphabet.b.rawValue
        b.letterCase = Int16(LetterCase.upper.rawValue)
        let userAlphabetA = UserAlphabetEntity(context: context)
        userAlphabetA.uuid = UUID()
        userAlphabetA.user = user
        userAlphabetA.hasDifficulty = true
        userAlphabetA.lesson = lesson1
        userAlphabetA.alphabet = a
        let userAlphabetB = UserAlphabetEntity(context: context)
        userAlphabetB.uuid = UUID()
        userAlphabetB.user = user
        userAlphabetB.hasDifficulty = true
        userAlphabetB.lesson = lesson1
        userAlphabetB.alphabet = b
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

        let b = AlphabetEntity(context: context)
        b.uuid = UUID()
        b.char = Alphabet.b.rawValue
        b.letterCase = Int16(LetterCase.both.rawValue)

        let c = AlphabetEntity(context: context)
        c.uuid = UUID()
        c.char = Alphabet.c.rawValue
        c.letterCase = Int16(LetterCase.both.rawValue)

        let d = AlphabetEntity(context: context)
        d.uuid = UUID()
        d.char = Alphabet.d.rawValue
        d.letterCase = Int16(LetterCase.both.rawValue)

        let e = AlphabetEntity(context: context)
        e.uuid = UUID()
        e.char = Alphabet.e.rawValue
        e.letterCase = Int16(LetterCase.both.rawValue)

        let f = AlphabetEntity(context: context)
        f.uuid = UUID()
        f.char = Alphabet.f.rawValue
        f.letterCase = Int16(LetterCase.both.rawValue)

        let g = AlphabetEntity(context: context)
        g.uuid = UUID()
        g.char = Alphabet.g.rawValue
        g.letterCase = Int16(LetterCase.both.rawValue)

        let h = AlphabetEntity(context: context)
        h.uuid = UUID()
        h.char = Alphabet.h.rawValue
        h.letterCase = Int16(LetterCase.both.rawValue)

        let i = AlphabetEntity(context: context)
        i.uuid = UUID()
        i.char = Alphabet.i.rawValue
        i.letterCase = Int16(LetterCase.both.rawValue)

        let j = AlphabetEntity(context: context)
        j.uuid = UUID()
        j.char = Alphabet.j.rawValue
        j.letterCase = Int16(LetterCase.both.rawValue)

        let k = AlphabetEntity(context: context)
        k.uuid = UUID()
        k.char = Alphabet.k.rawValue
        k.letterCase = Int16(LetterCase.both.rawValue)

        let l = AlphabetEntity(context: context)
        l.uuid = UUID()
        l.char = Alphabet.l.rawValue
        l.letterCase = Int16(LetterCase.both.rawValue)

        let m = AlphabetEntity(context: context)
        m.uuid = UUID()
        m.char = Alphabet.m.rawValue
        m.letterCase = Int16(LetterCase.both.rawValue)

        let n = AlphabetEntity(context: context)
        n.uuid = UUID()
        n.char = Alphabet.n.rawValue
        n.letterCase = Int16(LetterCase.both.rawValue)

        let o = AlphabetEntity(context: context)
        o.uuid = UUID()
        o.char = Alphabet.o.rawValue
        o.letterCase = Int16(LetterCase.both.rawValue)

        let p = AlphabetEntity(context: context)
        p.uuid = UUID()
        p.char = Alphabet.p.rawValue
        p.letterCase = Int16(LetterCase.both.rawValue)

        let q = AlphabetEntity(context: context)
        q.uuid = UUID()
        q.char = Alphabet.q.rawValue
        q.letterCase = Int16(LetterCase.both.rawValue)

        let r = AlphabetEntity(context: context)
        r.uuid = UUID()
        r.char = Alphabet.r.rawValue
        r.letterCase = Int16(LetterCase.both.rawValue)

        let s = AlphabetEntity(context: context)
        s.uuid = UUID()
        s.char = Alphabet.s.rawValue
        s.letterCase = Int16(LetterCase.both.rawValue)

        let t = AlphabetEntity(context: context)
        t.uuid = UUID()
        t.char = Alphabet.t.rawValue
        t.letterCase = Int16(LetterCase.both.rawValue)

        let u = AlphabetEntity(context: context)
        u.uuid = UUID()
        u.char = Alphabet.u.rawValue
        u.letterCase = Int16(LetterCase.both.rawValue)

        let v = AlphabetEntity(context: context)
        v.uuid = UUID()
        v.char = Alphabet.v.rawValue
        v.letterCase = Int16(LetterCase.both.rawValue)

        let w = AlphabetEntity(context: context)
        w.uuid = UUID()
        w.char = Alphabet.w.rawValue
        w.letterCase = Int16(LetterCase.both.rawValue)

        let x = AlphabetEntity(context: context)
        x.uuid = UUID()
        x.char = Alphabet.x.rawValue
        x.letterCase = Int16(LetterCase.both.rawValue)

        let y = AlphabetEntity(context: context)
        y.uuid = UUID()
        y.char = Alphabet.y.rawValue
        y.letterCase = Int16(LetterCase.both.rawValue)

        let z = AlphabetEntity(context: context)
        z.uuid = UUID()
        z.char = Alphabet.z.rawValue
        z.letterCase = Int16(LetterCase.both.rawValue)
    }

    private func initUppercaseAlphabet(context: NSManagedObjectContext) {
        let a = AlphabetEntity(context: context)
        a.uuid = UUID()
        a.char = Alphabet.a.rawValue
        a.letterCase = Int16(LetterCase.upper.rawValue)

        let b = AlphabetEntity(context: context)
        b.uuid = UUID()
        b.char = Alphabet.b.rawValue
        b.letterCase = Int16(LetterCase.upper.rawValue)

        let c = AlphabetEntity(context: context)
        c.uuid = UUID()
        c.char = Alphabet.c.rawValue
        c.letterCase = Int16(LetterCase.upper.rawValue)

        let d = AlphabetEntity(context: context)
        d.uuid = UUID()
        d.char = Alphabet.d.rawValue
        d.letterCase = Int16(LetterCase.upper.rawValue)

        let e = AlphabetEntity(context: context)
        e.uuid = UUID()
        e.char = Alphabet.e.rawValue
        e.letterCase = Int16(LetterCase.upper.rawValue)

        let f = AlphabetEntity(context: context)
        f.uuid = UUID()
        f.char = Alphabet.f.rawValue
        f.letterCase = Int16(LetterCase.upper.rawValue)

        let g = AlphabetEntity(context: context)
        g.uuid = UUID()
        g.char = Alphabet.g.rawValue
        g.letterCase = Int16(LetterCase.upper.rawValue)

        let h = AlphabetEntity(context: context)
        h.uuid = UUID()
        h.char = Alphabet.h.rawValue
        h.letterCase = Int16(LetterCase.upper.rawValue)

        let i = AlphabetEntity(context: context)
        i.uuid = UUID()
        i.char = Alphabet.i.rawValue
        i.letterCase = Int16(LetterCase.upper.rawValue)

        let j = AlphabetEntity(context: context)
        j.uuid = UUID()
        j.char = Alphabet.j.rawValue
        j.letterCase = Int16(LetterCase.upper.rawValue)

        let k = AlphabetEntity(context: context)
        k.uuid = UUID()
        k.char = Alphabet.k.rawValue
        k.letterCase = Int16(LetterCase.upper.rawValue)

        let l = AlphabetEntity(context: context)
        l.uuid = UUID()
        l.char = Alphabet.l.rawValue
        l.letterCase = Int16(LetterCase.upper.rawValue)

        let m = AlphabetEntity(context: context)
        m.uuid = UUID()
        m.char = Alphabet.m.rawValue
        m.letterCase = Int16(LetterCase.upper.rawValue)

        let n = AlphabetEntity(context: context)
        n.uuid = UUID()
        n.char = Alphabet.n.rawValue
        n.letterCase = Int16(LetterCase.upper.rawValue)

        let o = AlphabetEntity(context: context)
        o.uuid = UUID()
        o.char = Alphabet.o.rawValue
        o.letterCase = Int16(LetterCase.upper.rawValue)

        let p = AlphabetEntity(context: context)
        p.uuid = UUID()
        p.char = Alphabet.p.rawValue
        p.letterCase = Int16(LetterCase.upper.rawValue)

        let q = AlphabetEntity(context: context)
        q.uuid = UUID()
        q.char = Alphabet.q.rawValue
        q.letterCase = Int16(LetterCase.upper.rawValue)

        let r = AlphabetEntity(context: context)
        r.uuid = UUID()
        r.char = Alphabet.r.rawValue
        r.letterCase = Int16(LetterCase.upper.rawValue)

        let s = AlphabetEntity(context: context)
        s.uuid = UUID()
        s.char = Alphabet.s.rawValue
        s.letterCase = Int16(LetterCase.upper.rawValue)

        let t = AlphabetEntity(context: context)
        t.uuid = UUID()
        t.char = Alphabet.t.rawValue
        t.letterCase = Int16(LetterCase.upper.rawValue)

        let u = AlphabetEntity(context: context)
        u.uuid = UUID()
        u.char = Alphabet.u.rawValue
        u.letterCase = Int16(LetterCase.upper.rawValue)

        let v = AlphabetEntity(context: context)
        v.uuid = UUID()
        v.char = Alphabet.v.rawValue
        v.letterCase = Int16(LetterCase.upper.rawValue)

        let w = AlphabetEntity(context: context)
        w.uuid = UUID()
        w.char = Alphabet.w.rawValue
        w.letterCase = Int16(LetterCase.upper.rawValue)

        let x = AlphabetEntity(context: context)
        x.uuid = UUID()
        x.char = Alphabet.x.rawValue
        x.letterCase = Int16(LetterCase.upper.rawValue)

        let y = AlphabetEntity(context: context)
        y.uuid = UUID()
        y.char = Alphabet.y.rawValue
        y.letterCase = Int16(LetterCase.upper.rawValue)

        let z = AlphabetEntity(context: context)
        z.uuid = UUID()
        z.char = Alphabet.z.rawValue
        z.letterCase = Int16(LetterCase.upper.rawValue)
    }

    private func initLowercaseAlphabet(context: NSManagedObjectContext) {
        let a = AlphabetEntity(context: context)
        a.uuid = UUID()
        a.char = Alphabet.a.rawValue
        a.letterCase = Int16(LetterCase.lower.rawValue)

        let b = AlphabetEntity(context: context)
        b.uuid = UUID()
        b.char = Alphabet.b.rawValue
        b.letterCase = Int16(LetterCase.lower.rawValue)

        let c = AlphabetEntity(context: context)
        c.uuid = UUID()
        c.char = Alphabet.c.rawValue
        c.letterCase = Int16(LetterCase.lower.rawValue)

        let d = AlphabetEntity(context: context)
        d.uuid = UUID()
        d.char = Alphabet.d.rawValue
        d.letterCase = Int16(LetterCase.lower.rawValue)

        let e = AlphabetEntity(context: context)
        e.uuid = UUID()
        e.char = Alphabet.e.rawValue
        e.letterCase = Int16(LetterCase.lower.rawValue)

        let f = AlphabetEntity(context: context)
        f.uuid = UUID()
        f.char = Alphabet.f.rawValue
        f.letterCase = Int16(LetterCase.lower.rawValue)

        let g = AlphabetEntity(context: context)
        g.uuid = UUID()
        g.char = Alphabet.g.rawValue
        g.letterCase = Int16(LetterCase.lower.rawValue)

        let h = AlphabetEntity(context: context)
        h.uuid = UUID()
        h.char = Alphabet.h.rawValue
        h.letterCase = Int16(LetterCase.lower.rawValue)

        let i = AlphabetEntity(context: context)
        i.uuid = UUID()
        i.char = Alphabet.i.rawValue
        i.letterCase = Int16(LetterCase.lower.rawValue)

        let j = AlphabetEntity(context: context)
        j.uuid = UUID()
        j.char = Alphabet.j.rawValue
        j.letterCase = Int16(LetterCase.lower.rawValue)

        let k = AlphabetEntity(context: context)
        k.uuid = UUID()
        k.char = Alphabet.k.rawValue
        k.letterCase = Int16(LetterCase.lower.rawValue)

        let l = AlphabetEntity(context: context)
        l.uuid = UUID()
        l.char = Alphabet.l.rawValue
        l.letterCase = Int16(LetterCase.lower.rawValue)

        let m = AlphabetEntity(context: context)
        m.uuid = UUID()
        m.char = Alphabet.m.rawValue
        m.letterCase = Int16(LetterCase.lower.rawValue)

        let n = AlphabetEntity(context: context)
        n.uuid = UUID()
        n.char = Alphabet.n.rawValue
        n.letterCase = Int16(LetterCase.lower.rawValue)

        let o = AlphabetEntity(context: context)
        o.uuid = UUID()
        o.char = Alphabet.o.rawValue
        o.letterCase = Int16(LetterCase.lower.rawValue)

        let p = AlphabetEntity(context: context)
        p.uuid = UUID()
        p.char = Alphabet.p.rawValue
        p.letterCase = Int16(LetterCase.lower.rawValue)

        let q = AlphabetEntity(context: context)
        q.uuid = UUID()
        q.char = Alphabet.q.rawValue
        q.letterCase = Int16(LetterCase.lower.rawValue)

        let r = AlphabetEntity(context: context)
        r.uuid = UUID()
        r.char = Alphabet.r.rawValue
        r.letterCase = Int16(LetterCase.lower.rawValue)

        let s = AlphabetEntity(context: context)
        s.uuid = UUID()
        s.char = Alphabet.s.rawValue
        s.letterCase = Int16(LetterCase.lower.rawValue)

        let t = AlphabetEntity(context: context)
        t.uuid = UUID()
        t.char = Alphabet.t.rawValue
        t.letterCase = Int16(LetterCase.lower.rawValue)

        let u = AlphabetEntity(context: context)
        u.uuid = UUID()
        u.char = Alphabet.u.rawValue
        u.letterCase = Int16(LetterCase.lower.rawValue)

        let v = AlphabetEntity(context: context)
        v.uuid = UUID()
        v.char = Alphabet.v.rawValue
        v.letterCase = Int16(LetterCase.lower.rawValue)

        let w = AlphabetEntity(context: context)
        w.uuid = UUID()
        w.char = Alphabet.w.rawValue
        w.letterCase = Int16(LetterCase.lower.rawValue)

        let x = AlphabetEntity(context: context)
        x.uuid = UUID()
        x.char = Alphabet.x.rawValue
        x.letterCase = Int16(LetterCase.lower.rawValue)

        let y = AlphabetEntity(context: context)
        y.uuid = UUID()
        y.char = Alphabet.y.rawValue
        y.letterCase = Int16(LetterCase.lower.rawValue)

        let z = AlphabetEntity(context: context)
        z.uuid = UUID()
        z.char = Alphabet.z.rawValue
        z.letterCase = Int16(LetterCase.lower.rawValue)
    }
}
