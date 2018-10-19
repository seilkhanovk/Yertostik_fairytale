//
//  Module.swift
//  Ertegi
//
//  Created by Kuanysh on 02.08.17.
//  Copyright © 2017 KuanyshTeam. All rights reserved.
//

import UIKit

struct ertegiler {
    
    let title: String
    let cover: UIImage
    let path: String
    let author: String
//    let url: String
    
    init (_ title: String, _ cover: UIImage, _ path: String, _ author: String) {
        self.title = title
        self.cover = cover
        self.path = path
        self.author = author
    //    self.url = url
    }
    
    static func loadData() -> [ertegiler] {
        return [
                ertegiler("Ер төстік", #imageLiteral(resourceName: "Ер төстік"), "yerTostik", "Қазақ халық ертегілері"),
                ertegiler("Алдар көсенің сиқырлы тоны",#imageLiteral(resourceName: "Алдар көсенің сиқырлы тоны"), "aldarkose", "Қазақ халық ертегілері"),
                ertegiler("Тазша Бала", #imageLiteral(resourceName: "Тазша Бала"), "Tazsha Bala", "Ыбырай Алтынсарин"),
                ertegiler("Мақта қыз бен мысық",#imageLiteral(resourceName: "Мақта қыз бен мысық") ,  "Makta", "Ыбырай Алтынсарин"),
                ertegiler("Қарттың ұлына айтқан өсиеті", #imageLiteral(resourceName: "Қарттың ұлына айтқан өсиеті") ,"Kart", "Қазақ халық ертегілері"),
                ertegiler("Тапқыр Қоян",  #imageLiteral(resourceName: "Тапқыр қоян"),"Koyan", "Қазақ халық ертегілері"),
                ertegiler("Қарлығаштың құйрығы неге айыр?", #imageLiteral(resourceName: "Қарлығаштың құйрығы неге айыр?"),"aiyr", "Қазақ халық ертегілері"),
                ertegiler("Алты жасар Алпамыс", #imageLiteral(resourceName: "Алты жасар Алпамыс") ,"alty", "Қазақ халық ертегілері"),
                ertegiler("Ақшақар және жеті гном", #imageLiteral(resourceName: "Ақшақар және жеті гном"), "Gnom", "Шетел ертегілері"),
                //мысалы ертегі
                ertegiler("Кім неден күшті?", #imageLiteral(resourceName: "Кім неден күшті"), "kim", "Қазақ халық ертегілері"),
                ertegiler("Көгершін ертегісі",  #imageLiteral(resourceName: "Көгершін ертегісі"),"kogerwyn", "Қазақ халық ертегілері"),
                ertegiler("Торғай мен адам", #imageLiteral(resourceName: "Торғай мен адам"), "torgai i adam", "Қазақ халық ертегілері"),
                ertegiler("Екі қаз, бір бақа", #imageLiteral(resourceName: "Екі қаз, бір бақа"), "eki kaz bir baka", "Қазақ халық ертегілері"),
                ertegiler("Бөгелек", #imageLiteral(resourceName: "Бөгелек"), "bogelek","Қазақ халық ертегілері"),
                //классикалық ертегі
            ertegiler("Түлкінің алдағаны", #imageLiteral(resourceName: "Түлкінің алдағаны"),"tulkinin aldagany", "Қазақ халық ертегілері"),
                ertegiler("Арыстан патша",  #imageLiteral(resourceName: "Арыстан патша"),"arystan patwa", "Қазақ халық ертегілері"),
                ertegiler("Арыстан мен тышкан", #imageLiteral(resourceName: "Арыстан мен тышкан"),"arystan men tywkan", "Қазақ халық ертегілері"),
                ertegiler("Үш аю",  #imageLiteral(resourceName: "Үш аю"),"uw aiu", "Шетел ертегілері"),
                ertegiler("Алдар көсе мен Шықбермес Шығайбай", #imageLiteral(resourceName: "Алдар көсе мен Шықбермес Шығайбай"), "aldarkose12", "Қазақ халық ертегілері"),
                ertegiler("Маймыл мен шегірткенің сайысы",  #imageLiteral(resourceName: "Маймыл мен шегірткенің сайысы"),"maimyl men wegirtke", "Қазақ халық ертегілері"),
                ertegiler("Айлакер қоян",  #imageLiteral(resourceName: "Айлакер қоян"),"ailaker koyan", "Қазақ халық ертегілері")
        ]
    }
    
}
