//
//  ViewController.swift
//  JSValidator
//
//  Created by anthann on 2019/5/24.
//  Copyright © 2019 anthann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var validator = JSValidator()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let js = """
            // miniprogram/pages/page/page.js
        const app = require('../../utils/appframework.js')
        const ui = require('../../utils/uicomponents.js')
        const PageList = require('../../utils/pagelist.js')
        const WXColor = app.WXColor
        const Data = require('../../utils/dataset.js')
        Page({
            /**
             * 页面的初始数据
             */
            data: {
                array: [0,1,2,3,4,5,6,7,8,9]
            },
            /**
             * 生命周期函数--监听页面加载
             */
            onLoad: function (options) {
                this.setupViews()

                this.setupDataSets();
                
                if (this._onLoad){
                    this._onLoad(options);
                }
            },
            /**
             * 生命周期函数--监听页面初次渲染完成
             */
            onReady: function () {

                if (this._onReady){
                    this._onReady();
                }
            },

            /**
             * 生命周期函数--监听页面显示
             */
            onShow: function () {

                if (this._onShow){
                    this._onShow();
                }
            },

            /**
             * 生命周期函数--监听页面隐藏
             */
            onHide: function () {

                if (this._onHide){
                    this._onHide();
                }
            },

            /**
             * 生命周期函数--监听页面卸载
             */
            onUnload: function () {
               this.teardownDataSets();
                if (this._onUnload){
                    this._onUnload();
                }
            },
            /**
             * 页面相关事件处理函数--监听用户下拉动作
             */
            onPullDownRefresh: function () {

                if (this._onPullDownRefresh){
                    this._onPullDownRefresh();
                }
            },

            /**
             * 页面上拉触底事件的处理函数
             */
            onReachBottom: function () {

                if (this._onReachBottom){
                    this._onReachBottom();
                }
            },
            /**
             * 用户点击右上角分享
             */
            onShareAppMessage: function () {
            },

            setupViews: function () {
                let data = {}
                /**
                 * 开始拼接字符串：
                 * 遍历每个BaseFlexModel，构造小程序端的BaseFlexModel和Proxy
                 */
                let switch1 = new ui.WeuiSwitchModel({id: "switch1", checked: false, title: '开关23'})
        data["switch1"] = switch1
        this.bindProxy(switch1, "switch1")


                /**
                 * 结束拼接
                 */
                this.setData(data)
            },
             //设置数据表绑定
             setupDataSets: function() {
             /**
              * 拼接数据表监听
              */
             },
             
             teardownDataSets: function() {
             
                /**
                 *取消数据表监听
                 */
             },
            bindProxy: function (model, key) {
                let that = this
                let proxy = new Proxy(model, {
                    set: function (target, property, value) {
                        target[property] = value
                        if (target instanceof ui.BaseFlexModel) {
                            target.updateStyle()
                        }
                        let data = {}
                        data[key] = target
                        that.setData(data)
                        return true
                    },
                    get: function (target, prop) {
                        if (prop === '__target__') return target;  // This is where the magic happens!
                        else return target[prop];        // This is normal behavior..
                    }
                });
                this[key] = proxy
            },
            /**********************
             * 自定义事件：
             *
             */
             //页面变量
        //当前事件

             /**********************
              * 自定义方法：
              *
              */
             onSwitch1StateChange:function(e){
            this.switch1.updateValue(this,e)
            if (this._onSwitch1StateChange){
                this._onSwitch1StateChange(e)
            }
        },

        })

        """
        validator.validate(js: js)
    }


}

