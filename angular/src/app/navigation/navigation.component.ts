import { Component, OnInit } from '@angular/core';
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { Observable } from 'rxjs';
import { map, shareReplay } from 'rxjs/operators';
import { Router } from '@angular/router';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit {
  
  currUrl = localStorage.getItem('url');

  isHandset$: Observable<boolean> = this.breakpointObserver.observe(Breakpoints.Handset)
  .pipe(
    map(result => result.matches),
    shareReplay()
  );

  constructor(private breakpointObserver: BreakpointObserver, public router: Router) {}

  ngOnInit() {
    if (!this.currUrl) {
      this.currUrl = environment.flask_url
      localStorage.setItem('url', this.currUrl)
    }
  }

  urlIsCos(): Boolean {
    return this.currUrl === environment.cos_url
  }
  
  changeToCos() {
    localStorage.setItem('url', environment.cos_url)
    this.currUrl = environment.cos_url
    location.reload()
  }

  changeToFlask() {
    localStorage.setItem('url', environment.flask_url)
    this.currUrl = environment.flask_url
    location.reload()
  }
}
