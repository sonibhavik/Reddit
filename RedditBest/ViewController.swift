//
//  ViewController.swift
//  RedditBest
//
//  Created by Bhavik Soni on 18/06/19.
//  Copyright © 2019 Bhavik Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var license: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var licenseText: UILabel!
    @IBAction func accept(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(1, forKey: "flag")
    }
    @IBAction func reject(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(0, forKey: "flag")
        exit(0)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        licenseText.text = """

            Thanks for inquiring about the Reddit application programming interfaces and the related data, code, and other materials provided by Reddit with the API (the “Reddit APIs”). Collectively, we refer to the terms below, any additional terms, terms within the accompanying API documentation, and any applicable policies and guidelines as the "Terms." By using the Reddit APIs, you agree to the Terms with Reddit, Inc. (“Reddit”). If you disagree with any of these Terms, Reddit does not grant you a license to use the Reddit APIs.
        
        1. Registration.
        a. Accepting the Terms. You may not use the Reddit APIs and may not accept the Terms if: (a) you are not of legal age to form a binding contract with Reddit, and/or (b) you are a person barred from using or receiving the Reddit APIs under the applicable laws of the United States or other countries, including the country in which you are resident, or from which you use the Reddit APIs.
        
        b. Corporate Use. If you are accepting the Terms on behalf of your employer or another entity, you represent and warrant that: (i) you have full legal authority to bind your employer, or the applicable entity, to the Terms; (ii) you have read and understand these Terms; and (iii) you agree, on behalf of the party that you represent, to the Terms. If you don’t have the legal authority to bind your employer or the applicable entity, please do not use the Reddit APIs.
        
        c. Contact Information. In order to access the Reddit APIs, you may be required to provide identification information (eg. contact details). This information must be up to date and accurate at all times.
        
        2. Your Use of Reddit APIs.
        a. License. Subject to the terms and conditions of these Terms, Reddit grants You a worldwide, non-exclusive, non-transferable, non-sublicensable, and revocable license to use the Reddit APIs in accordance with the terms and conditions set forth herein. All rights not expressly granted to you are reserved by Reddit.
        
        b. End Users. You agree that you will ensure that your End Users comply with all associated terms and conditions of these Terms.
        
        c. Compliance with Reddit Terms and Rules. You agree to comply with the Reddit User Agreement and Privacy Policy, which may be amended from time to time. Further, you agree to comply with the Reddit API Rules.
        
        d. User Content. Reddit user photos, text and videos ("User Content") are owned by the users and not by Reddit. Subject to the terms and conditions of these Terms, Reddit grants You a non-exclusive, non-transferable, non-sublicensable, and revocable license to copy and display the User Content using the Reddit API through your application, website, or service to end users. You may not modify the User Content except to format it for such display. You will comply with any requirements or restrictions imposed on usage of User Content by their respective owners, which may include "all rights reserved" notices, Creative Commons licenses or other terms and conditions that may be agreed upon between you and the owners.
        
        e. Removals. You may receive notices or requests to remove content pursuant to the Reddit Content Policy. You will escalate these requests to Reddit, as needed, by sending an email to contact@reddit.com.
        
        f. Privacy Policy. You will disclose in your application through a privacy policy how you collect, use, store, and disclose data collected from visitors, including, where applicable, that third parties (including advertisers) may serve content and/or advertisements and collect information directly from visitors that may include the use of cookies. In addition, by using the Reddit APIs, Reddit may use submitted information in accordance with our privacy policy (https://www.reddit.com/help/privacypolicy).
        
        g. Compliance with Law. You will comply with all applicable laws or regulations (including, without limitation, laws regarding the import or export of data, or software, privacy, and local laws).
        
        h. Permitted Access. You will only access (or attempt to access) Reddit APIs using OAuth 2, as described in the documentation of the Reddit APIs. You must use the OAuth token when accessing the Reddit APIs and you will not misrepresent or mask either the user agent or OAuth identity when using the Reddit APIs.
        
        i. API Limitations. Reddit may set and enforce limits on your use of the Reddit APIs (e.g. limiting the number of API requests that you may make or the number of users you may serve), in our sole discretion.
        
        j. Libraries, Wrappers and Extensions. There are some great libraries, wrappers, and extensions that help bring Reddit to our users, but if created, you need to comply with any limitations or restrictions Reddit imposes.
        
        3. Fees; Restrictions on Use.
        a. Fees. Reddit reserves the right to charge fees for future use or access to the Reddit APIs, rates to be determined in Reddit’s sole discretion.
        
        b. Restrictions. You must not, and must not allow those acting on your behalf to: i. use the Reddit APIs to encourage or promote illegal activity or violation of third party rights. ii. reverse engineer, decompile, disassemble or translate the Reddit APIs or otherwise derive the source code from any Reddit API or any part thereof, except to the extent that this restriction is expressly prohibited by applicable law. iii. circumvent or exceed limitations on calls and use of the Reddit APIs as outlined in the API Documentation, or otherwise use the Reddit APIs in a manner that would constitute excessive or abusive usage or would disrupt or unreasonably interfere with the Reddit APIs or the servers or networks that provide the Reddit APIs. If Reddit believes that you are in breach of this section, Reddit reserves the right to permanently block your access to the Reddit APIs. iv. interfere with, modify, disrupt or disable features or functionality of the Reddit APIs, including but not limited to, any mechanism used to restrict or control functionality, or defeat, avoid, bypass, remove, deactivate or otherwise circumvent any software protection or monitoring mechanism of the Reddit APIs. v. use the Reddit APIs with the intent of introducing any viruses, worms, defects, Trojan horses, malware or any other items of a destructive nature. vi. sell, lease or sublicense the Reddit APIs or access thereto or derive revenues from the use or provision of the Reddit APIs, whether for direct commercial or monetary gain unless there is express written approval from Reddit. vii. use the Reddit APIs to spam, incentivize, or harass users.
        
        c. Widget Restrictions. Reddit may provide one or more widgets for use with the Reddit APIs (the “Reddit Widgets”), including Reddit Widgets to embed certain User Content on a website or webpage controlled by you. In addition to the foregoing restrictions, You acknowledge and agree that you will display the Reddit Widgets as made available to you, unaltered, unobfuscated, and in accordance with any accompanying documentation.
        
        4. Trademarks; Attribution; Publicity.
        a. Use of Reddit Trademarks. You are not permitted to use the Reddit Trademarks in, or as part of the name of your application, or any logos used to promote or identify your application, unless expressly authorized in writing by Reddit or in these Terms. Further, You agree not to: (1) create any derivative works of the Reddit Trademarks that may create or reasonably imply Reddit’s endorsement, association or sponsorship with your application; (2) use the Reddit Trademarks in such a way that would mislead, deceive or confuse users, including, but not limited to, using or registering any mark that is confusingly similar to any Reddit Trademarks; and (c) challenge Reddit’s ownership of the Reddit Trademarks and You will not take any action inconsistent with this ownership and You will cooperate, at Reddit’s request and expense, in any action (including the conduct of legal proceedings) which Reddit deems necessary or desirable to establish or preserve Reddit’s exclusive rights in, and to, the Reddit Trademarks. All use of the Reddit Trademarks and all goodwill arising out of such use, will inure to Reddit’s benefit.
        
        b. Attribution. You agree to display any attribution(s) required by Reddit as described in the documentation for the Reddit APIs. When you use the Reddit APIs, Reddit hereby grants to you a non-transferable, non-sublicenseable, nonexclusive license while the Terms are in effect to use or display “Reddit” wordmark, so long as you use “for” preceding such use (e.g., “[insert name] for Reddit”).
        
        c. Publicity. You will not make any statement regarding your use of the Reddit APIs which suggests partnership with, sponsorship by, or endorsement by Reddit, without Reddit's prior written approval.
        
        Support; Changes; Feedback
        a. Support. Reddit may elect to provide you with support or modifications for the Reddit APIs, in its sole discretion, and may terminate such support at any time without notice to you.
        
        b. Changes to the Reddit APIs. Reddit may change, suspend, or discontinue any aspect of the Reddit APIs at any time, including the availability of any Reddit APIs.
        
        c. Feedback. You agree and acknowledge that any feedback that you provide with respect to the Reddit APIs may be used, modified, and/or incorporated into any Reddit products and services without any restriction, obligation or compensation to you.
        
        6. Termination.
        You may stop using the Reddit APIs at any time, with or without notice to Reddit. Reddit reserves the right to revoke your access to the Reddit APIs for any reason and for any period of time, without notice to you. Upon any termination of the Terms or discontinuation of your access to the Reddit APIs, you will immediately stop using the Reddit APIs, delete any cached or stored content that was permitted or transferred via the Reddit APIs and stop any further distribution or updates of any mobile applications (as may be applicable).
        
        7. Disclaimer, Limitation of Liability, Indemnity.
        a. Disclaimer. Reddit does not represent or warrant that any Reddit APIs are free of inaccuracies, errors, bugs, or interruptions, or are reliable, accurate, complete, or otherwise valid. The Reddit APIs are provided "as is" with no warranty, express or implied, of any kind and Reddit expressly disclaims any and all warranties and conditions, including, but not limited to, any implied warranty of merchantability, fitness for a particular purpose, availability, security, title and/or non-infringement. Your use of the Reddit APIs is at your own discretion and risk, and you will be solely responsible for any damage that results from the use of any Reddit APIs including, but not limited to, any damage to your computer system or loss of data.
        
        b. Limitation of Liability. Reddit shall not be liable to you for any direct, indirect, incidental, consequential, special or exemplary damages arising out of, or in connection with, use of the Reddit APIs, whether based on tort (including negligence or otherwise), breach of contract, breach of warranty, or any other pecuniary loss, whether or not Reddit has been advised of the possibility of such damages. Under no circumstances shall Reddit be liable to you for any amount.
        
        c. Indemnity. To the maximum extent permitted by applicable law, you agree to hold harmless and indemnify Reddit and its subsidiaries, affiliates, officers, agents, licensors, and employees from and against any third-party claim arising from or in any way related to your use of the Reddit APIs, including any liability or expense arising from all claims, losses, damages (actual and/or consequential), suits, judgments, litigation costs and attorneys' fees, of every kind and nature. Reddit shall use good faith efforts to provide you with written notice of such claim, suit or action.
        
        8. Miscellaneous.
        a. Confidentiality. Our communications to you and our Reddit APIs may contain Reddit confidential information. Reddit confidential information includes any materials, communications, and information that are marked confidential or that would normally be considered confidential under the circumstances. You may use this Confidential Information only as necessary in exercising your rights granted in this Agreement and you will not disclose it to any third party without Reddit's prior written consent. You agree that you will protect this confidential information from unauthorized use, access, or disclosure in the same manner that you would use to protect your own confidential and proprietary information of a similar nature and in no event with less than a reasonable degree of care. Reddit confidential information does not include information that you independently developed, that was rightfully given to you by a third party without confidentiality obligation, or that becomes public through no fault of your own. You may disclose Reddit confidential information when compelled to do so by law if you provide us reasonable prior notice, unless a court orders that we not receive notice.
        
        b. Modification to these Terms. Reddit may modify the Terms or any portion to, at any time. You should look at the Terms regularly. We'll post notice of modifications to the Terms within the documentation of each applicable API or to this website. By continuing to access or use the Reddit APIs after modifications or revisions to the Terms become effective, you agree to be bound by the revised or modified Terms.
        
        c. General. These Terms do not create any agency, partnership or joint venture between the parties. Nothing in the Terms will limit either party's ability to seek injunctive relief. Reddit is not liable for failure or delay in performance to the extent caused by circumstances beyond our reasonable control. Any failure to enforce any provision of these Terms will not constitute a waiver thereof or of any other provision. If any section (or portion of a section) of these Terms is invalid, illegal or unenforceable, the rest of the Terms will remain in effect. These Terms are governed by the laws of the State of California, excluding its conflict of laws principles. For any dispute relating to these Terms, the parties consent to personal jurisdiction and exclusive venue in San Francisco County, California. These Terms are the entire agreement between you and Reddit relating to its subject and supersede any prior or contemporaneous agreements on that subject.
        
        d. Questions. Questions or comments about these Terms or the Reddit APIs may be directed to api@reddit.com"
        """
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.layoutIfNeeded()
        scrollView.setNeedsDisplay()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
