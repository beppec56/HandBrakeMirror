﻿// --------------------------------------------------------------------------------------------------------------------
// <copyright file="ScanProgressEventArgs.cs" company="HandBrake Project (http://handbrake.fr)">
//   This file is part of the HandBrake source code - It may be used under the terms of the GNU General Public License.
// </copyright>
// <summary>
//   Scan Progress Event Args
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace HandBrake.ApplicationServices.EventArgs
{
    using System;
    using System.Runtime.Serialization;

    /// <summary>
    /// Scan Progress Event Args
    /// </summary>
    [DataContractAttribute]
    public class ScanProgressEventArgs : EventArgs
    {
        /// <summary>
        /// Gets or sets the title currently being scanned.
        /// </summary>
        [DataMember]
        public int CurrentTitle { get; set; }

        /// <summary>
        /// Gets or sets the total number of Titles.
        /// </summary>
        [DataMember]
        public int Titles { get; set; }
    }
}
