package com.gdi.core.view {

	/**
	 * @author grantdavis
	 */
	public interface IViewController {
		
		function get view():BaseView;
		function set view( $view :BaseView ):void;
		
		function get delegate():IViewControllerDelegate;
		function set delegate( $delegate :IViewControllerDelegate ):void;
		
		function loadView():void;
		function unloadView():void;
		
		function viewWillAppear( $animated :Boolean ):void;
		function animateViewIn():void;
		function viewDidAppear( $animated :Boolean ):void;
		
		function viewWillDisappear( $animated :Boolean ):void;
		function animateViewOut():void;
		function viewDidDisappear( $animated :Boolean ):void;
	}
}
