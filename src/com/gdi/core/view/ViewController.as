package com.gdi.core.view {

	/**
	 * @author grantdavis
	 */
	public class ViewController
		implements IViewController {
		
		protected var _view	:BaseView;
		protected var _delegate	:IViewControllerDelegate;
		
		public function get view() : BaseView { return _view; }
		public function set view($view : BaseView) : void {
			_view = $view;
		}
		
		public function get delegate() : IViewControllerDelegate { return _delegate; }
		public function set delegate($delegate : IViewControllerDelegate) : void {
			_delegate = $delegate;
		}

		public function loadView() : void {
			this.view = new BaseView( this );
		}
		
		public function unloadView() : void {
			this.view = null;
		}
		
		public function viewWillAppear($animated : Boolean) : void {
		}
		
		public function viewDidAppear($animated : Boolean) : void {
		}
		
		public function viewWillDisappear($animated : Boolean) : void {
		}
		
		public function viewDidDisappear($animated : Boolean) : void {
		}
		
		public function animateViewIn() : void {
		}
		
		public function animateViewOut() : void {
		}
	}
}
