//
//  ViewController.swift
//  CalculatorDemo
//
//  Created by 王颜华 on 16/1/30.
//  Copyright © 2016年 EmyWong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//展示Label 属性
    @IBOutlet weak var display: UILabel!
    
//设置一个bool属性判断是否编辑过 如果未编辑就直接替换0：7 编辑过则加一起：78
    var isediting:Bool = false

//设置一个可变数组 用来存数字 
    var numberArr:NSMutableArray = []
    
//设置一个变量 值为0
    var type = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //选择数字
    @IBAction func ChooseNo(sender: UIButton) {
        
        //设置一个常量 值是Button的title 因为是optional 所以需要拆包
        let digit = sender.currentTitle!
        
        //判断如果编辑过则连在一起
        if isediting{
            
            display.text = display.text! + digit
        
        }
        //未编辑就替换掉0 并使编辑状态变为 已编辑过
        else
        {
            display.text = digit
            
            isediting = true
        }
        
    }

//加法
    @IBAction func addAction(sender: UIButton) {
        
        let number = display.text!
        
        numberArr.insertObject(number, atIndex: numberArr.count)
        
        isediting = false
        
        type = 1
        
    }
//减法
    @IBAction func subAction(sender: UIButton) {
        
        let number = display.text!
        
        numberArr.insertObject(number, atIndex: numberArr.count)
        
        isediting = false
        
        type = 2
    }
//乘法
    @IBAction func mulAction(sender: UIButton) {
        
        let number = display.text!
        
        numberArr.insertObject(number, atIndex: numberArr.count)
        
        isediting = false
        
        type = 3
    }
//除法
    @IBAction func divAction(sender: UIButton) {
        
        let number = display.text!
        
        numberArr.insertObject(number, atIndex: numberArr.count)
        
        isediting = false
        
        type = 4
        
    }
//等于
    @IBAction func equalAction(sender: UIButton) {
        
        var result = 0
        
        let number1 = display.text!
        
        numberArr.insertObject( number1, atIndex: numberArr.count)
        
        print(numberArr)
        
        
            switch type
            {
            case 1:
                for (var i = 0; i < numberArr.count; i++)
                {
                    
                    result = result + self.numberArr[i].integerValue
                    
                }
                break
                
                
            case 2:
                for (var i = 0; i < numberArr.count; i++)
                {
                    if i==0 {
                        result = self.numberArr[i].integerValue
                    }
                    else
                    {
                    result = result - self.numberArr[i].integerValue
                    }
                }
                break
                
            case 3:
                
                for (var i = 0; i < numberArr.count; i++)
                {
                    
                    if i==0 {
                        result = self.numberArr[i].integerValue
                    }
                    else
                    {
                        result = result * self.numberArr[i].integerValue
                    }

                }
                break
                
            case 4:
                
                for (var i = 0; i < numberArr.count; i++)
                {
                    
                    if i==0 {
                        result = self.numberArr[i].integerValue
                    }
                    else
                    {
                        result = result / self.numberArr[i].integerValue
                    }

                }
                break
                
            default:
                
                let string = NSString(string: display.text!)
                result = string.integerValue
                break
         }
            
            display.text = String(result)
            isediting = false;
            numberArr.removeAllObjects()
        
    }
//置为0
    @IBAction func nilAction(sender: UIButton) {
        
        display.text = "0"
        type = 0
        isediting = false
        if numberArr.count != 0
        {
            numberArr.removeAllObjects()
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }


}

