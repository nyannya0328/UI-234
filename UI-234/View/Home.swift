//
//  Home.swift
//  UI-234
//
//  Created by にゃんにゃん丸 on 2021/06/13.
//

import SwiftUI

struct Home: View {
    @State var selected = "INCOMING"
    @Namespace var animation
    
    @State var line : CGFloat = 20
    
    @State var weeks : [Week] = []
    
    
    @State var currendDay : Week = Week(day: "", date: "", amountSpent: 0)
    var body: some View {
        VStack{
            
            HStack{
                
                Image("m1")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                   
                
                Spacer(minLength: 0)
                
                Image("menu")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                  
                
            }
            .padding()
            
            Text("STATICS")
                .font(.title.italic())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading,5)
                
               
            
            HStack{
                
                Text("INCOMING")
                    .font(.title3.italic())
                    .foregroundColor(selected == "INCOMING" ? Color.purple : Color.black)
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .background(
                    
                        ZStack{
                            
                            if selected == "INCOMING"{
                                
                                Color.white
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                    .cornerRadius(10)
                                
                                
                            }
                            
                        }
                    
                    )
                    .onTapGesture {
                        withAnimation{
                            
                            selected = "INCOMING"
                        }
                    }
                   
                    
                
                
                
                
               Text("OUTCOMING")
                .font(.title3.italic())
                .foregroundColor(selected == "OUTCOMING" ? Color.green : Color.black)
                .padding(.vertical,10)
                .padding(.horizontal,20)
                .background(
                
                    ZStack{
                        
                        if selected == "OUTCOMING"{
                            
                            Color.white
                                .matchedGeometryEffect(id: "TAB", in: animation)
                                .cornerRadius(10)
                            
                            
                        }
                        
                    }
                
                )
                .onTapGesture {
                    withAnimation{
                        
                        
                        selected = "OUTCOMING"
                    }
                }
                
                
                
            }
            .padding(.vertical)
            .padding(.horizontal)
            .background(Color.black.opacity(0.35))
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
            .padding(.top,10)
            
            
            
            HStack(spacing:40){
                
                ZStack{
                    
                    let progress = currendDay.amountSpent / 500
                    
                    Circle()
                        .stroke(Color.white,lineWidth: 20)
                        
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color.yellow,style: StrokeStyle(lineWidth: line, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.init(degrees: -90))
                    
                    
                  Image(systemName: "dollarsign.square.fill")
                    .font(.title.bold())
                    .frame(width: 50, height: 60)
                    .foregroundColor(.black)
                      
                    
                    
                }
                .frame(maxWidth: 180)
                
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("SPENT")
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.3))
                    
                    let amount = String(format: "%.2F", currendDay.amountSpent)
                    
                    
                  Text("$\(amount)")
                        .font(.title.bold())
                        .foregroundColor(.white)
                    
                    
                    Text("MAX")
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.3))
                    Text("$500")
                        .font(.title.bold())
                        .foregroundColor(.white)
                       
                
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
            }
            .padding(.leading,30)
            
            
            ZStack{
                
                if UIScreen.main.bounds.height < 750{
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        ButtomSheet(weeks: $weeks, currendDay: $currendDay, animation: animation)
                            .padding([.horizontal,.top])
                        
                    }
                    
                    
                }
                
                else{
                    
                    ButtomSheet(weeks: $weeks, currendDay: $currendDay, animation: animation)
                        .padding([.horizontal,.top])
                    
                    
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .background(Color.white.clipShape(CustomShape(radi: 30, corner: [.topLeft,.topRight]))
            .ignoresSafeArea(.all, edges: .bottom))
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("bg").ignoresSafeArea())
        .onAppear(perform: {
            getWeekDays()
        })
    }
    
    func getWeekDays(){
        let calender = Calendar.current
        
        let week = calender.dateInterval(of: .weekOfMonth,for: Date())
        
        guard let starData = week?.start else {return}
        
        
        for index in 0..<7{
            
            
            guard let date = calender.date(byAdding: .day, value: index, to: starData) else {return}
            
            
            let format = DateFormatter()
            
            format.dateFormat = "EEE"
            
            
            var day = format.string(from: date)
            
            day.removeLast()
            
            
            format.dateFormat = "dd"
            
            let dateString = format.string(from: date)
            
            weeks.append(Week(day: day, date: dateString, amountSpent: index == 0 ? 60 : (CGFloat(index) * 70)))
            
        }
        
        self.currendDay = weeks.first!
    
        
       
            
            
            
        
        
    }
}

struct ButtomSheet : View {
    @Binding var  weeks : [Week]
    @Binding var currendDay : Week
    var animation : Namespace.ID
    var body: some View{
        
        VStack{
            
            Capsule()
                .fill(Color.gray)
                .frame(width: 100, height: 5)
            
            
            HStack{
                
                VStack(alignment: .leading, spacing: 15, content: {
                    Text("Youre Burance")
                        .font(.footnote.italic())
                        .foregroundColor(.black)
                    
                    Text("13 JUN")
                        .font(.footnote.italic())
                        .foregroundColor(.black)
                    
                    
                })
                
                Spacer(minLength: 0)
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.title.bold())
                        .foregroundColor(.primary)
                       
                })
                .offset(y: -2)
                
            }
            .padding(.top)
            
            
            HStack{
                
                Text("22,306,07")
                    .font(.title.weight(.heavy))
                    .foregroundColor(.primary)
                
                
                Spacer(minLength: 0)
                
                
                Image(systemName: "arrow.up")
                    .font(.title.bold())
                    .foregroundColor(.primary)
                Text("15%")
                    .foregroundColor(.gray)
                
                
                
                
               
                
                
                
            }
            .padding(.top)
            
            
            
            HStack{
                
                
                
                ForEach(weeks){week in
                    
                    VStack(spacing:15){
                        
                        
                        
                        Text(week.day)
                            .font(.title3.italic())
                            .foregroundColor(currendDay.id == week.id ? Color.white.opacity(0.8) : .black)
                        
                        Text(week.date)
                            .font(.title3.italic())
                            .foregroundColor(currendDay.id == week.id ? Color.white : .black)
                        
                            
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,10)
                    .background(
                        
                        ZStack{
                            
                            if currendDay.id == week.id{
                                
                                Color.blue
                             .matchedGeometryEffect(id: "WEEK", in: animation)
                            }
                            
                        }
                    
                    )
                    .onTapGesture {
                        withAnimation{
                            
                            currendDay = week
                        }
                    }
                    
                    
                }
                
            }
            .padding(.top,10)
            
            
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image("right-arrow")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .padding(.vertical,10)
                    .padding(.horizontal,10)
                    .background(Color.purple)
                    .clipShape(Circle())
                
                
            })
            
            
            
            
        }

    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomShape : Shape {
    var radi : CGFloat
    var corner : UIRectCorner
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radi, height: radi))
        
        return Path(path.cgPath)
        
    }
}
